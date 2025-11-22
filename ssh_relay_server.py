#!/usr/bin/env python3

## Author: Allen Jung (ALJ225@pitt.edu)

import os
import re
import socket
import sys
import threading
import time

import paramiko
from paramiko import RSAKey, ServerInterface
from paramiko import AUTH_SUCCESSFUL, AUTH_FAILED
from paramiko import OPEN_SUCCEEDED, OPEN_FAILED_ADMINISTRATIVELY_PROHIBITED

# ============ CONFIG ============
LISTEN_HOST = "0.0.0.0"
LISTEN_PORT = 22

UPSTREAM_HOST = "11.11.0.46"
UPSTREAM_PORT = 22

HOST_KEY_FILE = "relay_host_key.pem"


# ========== HELPER: host key ==========
def get_or_create_host_key(path: str) -> RSAKey:
    if os.path.exists(path):
        return RSAKey(filename=path)
    key = RSAKey.generate(2048)
    key.write_private_key_file(path)
    print(f"[+] Generated new host key at {path}")
    return key


# ========== ANSI CLEANUP ==========
ansi_escape = re.compile(r'\x1b\[[0-9;]*[A-Za-z]')


def clean_ansi(s: str) -> str:
    return ansi_escape.sub('', s)


# ========== SERVER IMPLEMENTATION ==========
class RelaySSHServer(ServerInterface):
    """
    Paramiko ServerInterface that:
    - Accepts username/password
    - Uses those credentials to connect to UPSTREAM_HOST
    - When a shell is requested, opens a shell on the upstream server
      and relays traffic.
    """

    def __init__(self):
        super().__init__()
        self.username = None
        self.password = None

        self.up_client = None       # paramiko.SSHClient for upstream
        self.up_chan = None         # upstream shell channel

        self.auth_ok = False
        self.shell_event = threading.Event()

    # ---- Authentication ----
    def check_auth_password(self, username, password):
        """
        Use the provided username/password to authenticate to upstream server.
        If that succeeds, we allow this SSH login.
        """
        print(f"[auth] Attempting upstream login for "
              f"{username}@{UPSTREAM_HOST}:{UPSTREAM_PORT}")
        self.username = username
        self.password = password

        try:
            client = paramiko.SSHClient()
            client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            client.connect(
                UPSTREAM_HOST,
                port=UPSTREAM_PORT,
                username=username,
                password=password,
                timeout=10,
            )
            self.up_client = client
            self.auth_ok = True
            print(f"[auth] Upstream auth SUCCESS for {username}:{password}")
            return AUTH_SUCCESSFUL
        except Exception as e:
            print(f"[auth] Upstream auth FAILED for {username}:{password}: {e!r}")
            self.auth_ok = False
            return AUTH_FAILED

    # ---- Channels ----
    def check_channel_request(self, kind, chanid):
        """
        Allow only 'session' channels (for interactive shells).
        """
        if kind == "session":
            return OPEN_SUCCEEDED
        return OPEN_FAILED_ADMINISTRATIVELY_PROHIBITED

    def check_channel_pty_request(self, channel, *args, **kwargs):
        # Allow PTY so client gets a proper terminal
        return True

    def check_channel_shell_request(self, channel):
        """
        When the client requests a shell, open a **shell** on the upstream server.
        """
        if not self.auth_ok or self.up_client is None:
            print("[shell] No upstream client; denying shell.")
            return False

        try:
            self.up_chan = self.up_client.invoke_shell()
            self.up_chan.setblocking(True)
            print("[shell] Opened upstream shell channel.")
            self.shell_event.set()
            return True
        except Exception as e:
            print(f"[shell] Failed to open upstream shell: {e!r}")
            return False


# ========== RELAY / BRIDGING ==========

def relay_client_to_upstream(src_chan, dst_chan):
    """
    Relay data from client to upstream, but log it as reconstructed commands
    instead of raw keystrokes.
    """
    cmd_buf = ""

    try:
        while True:
            data = src_chan.recv(1024)
            if not data:
                print("[relay client->upstream] EOF / channel closed.")
                break

            # Always forward raw bytes to upstream
            dst_chan.sendall(data)

            # Decode for logging
            text = data.decode(errors="ignore")

            for ch in text:
                # Enter pressed: log the command
                if ch in ("\r", "\n"):
                    #if cmd_buf.strip():
                    #    print(f"[CMD] {cmd_buf}")
                    cmd_buf = ""
                # Backspace / delete
                elif ch in ("\x7f", "\b"):
                    cmd_buf = cmd_buf[:-1]
                # Ignore most control chars (ESC, etc.)
                elif ord(ch) < 32:
                    continue
                else:
                    cmd_buf += ch
    except Exception as e:
        print(f"[relay client->upstream] error: {e!r}")


def relay_upstream_to_client(src_chan, dst_chan):
    """
    Relay data from upstream to client, printing readable output.
    """
    try:
        while True:
            data = src_chan.recv(1024)
            if not data:
                print("[relay upstream->client] EOF / channel closed.")
                break

            # Forward raw bytes to client
            dst_chan.sendall(data)

            # Decode + clean for logging
            text = clean_ansi(data.decode(errors="ignore"))
            if text:
                print(text, end="")
                sys.stdout.flush()
    except Exception as e:
        print(f"[relay upstream->client] error: {e!r}")


def handle_connection(client_sock, host_key):
    t = paramiko.Transport(client_sock)
    t.add_server_key(host_key)
    server = RelaySSHServer()

    try:
        t.start_server(server=server)
    except paramiko.SSHException:
        print("[-] SSH negotiation failed")
        t.close()
        return

    # Wait for a session channel from the client
    chan = t.accept(timeout=30)
    if chan is None:
        print("[-] No channel; closing connection")
        t.close()
        if server.up_client:
            server.up_client.close()
        return

    print("[+] Client channel opened. Waiting for shell request...")
    # Wait for shell to be established (upstream invoke_shell done)
    if not server.shell_event.wait(timeout=20):
        print("[-] No shell request; closing connection")
        chan.close()
        t.close()
        if server.up_client:
            server.up_client.close()
        return

    up_chan = server.up_chan
    if up_chan is None:
        print("[-] Upstream channel not available; closing")
        chan.close()
        t.close()
        if server.up_client:
            server.up_client.close()
        return

    print("[+] Relay established. Client is now talking to upstream server.")

    # Start two relay threads: client -> upstream and upstream -> client
    t1 = threading.Thread(
        target=relay_client_to_upstream,
        args=(chan, up_chan),
        daemon=True,
    )
    t2 = threading.Thread(
        target=relay_upstream_to_client,
        args=(up_chan, chan),
        daemon=True,
    )
    t1.start()
    t2.start()

    # Wait for one side to finish
    t1.join()
    t2.join()

    print("\n[*] Closing channels and upstream client.")
    try:
        chan.close()
    except Exception:
        pass
    try:
        up_chan.close()
    except Exception:
        pass
    try:
        t.close()
    except Exception:
        pass
    if server.up_client:
        server.up_client.close()


# ========== MAIN LOOP ==========

def main():
    host_key = get_or_create_host_key(HOST_KEY_FILE)

    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.bind((LISTEN_HOST, LISTEN_PORT))
    sock.listen(100)

    print(f"[+] SSH relay server listening on {LISTEN_HOST}:{LISTEN_PORT}")
    print(f"[+] Relaying to upstream {UPSTREAM_HOST}:{UPSTREAM_PORT}")
    print("[!] Use only where you are authorized. This acts like a jump host / proxy.\n")

    try:
        while True:
            client_sock, addr = sock.accept()
            print(f"[+] New SSH client from {addr}")
            threading.Thread(
                target=handle_connection,
                args=(client_sock, host_key),
                daemon=True,
            ).start()
    except KeyboardInterrupt:
        print("\n[*] Relay server shutting down.")
    finally:
        sock.close()


if __name__ == "__main__":
    # For debugging, you can enable Paramiko logging:
    # paramiko.util.log_to_file("relay_paramiko.log")
    main()
