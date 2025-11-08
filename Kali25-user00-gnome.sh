#!/bin/bash


## CURRENTLY IN USE WITH KALI 2025.3


echo "ENABLE root LOGIN"
sudo apt install -y kali-root-login ##&& sudo dpkg-reconfigure kali-grant-root

echo "SETTING root PASSWORD TO toor"
echo -e "toor\ntoor" | sudo passwd

sudo apt -y install isc-dhcp-client isc-dhcp-client-ddns
 
echo ""
echo "RENEW IP ..."
echo ""
dhclient -r
dhclient
dhclient -r
dhclient

echo ""
echo "SUDO APT UDATE..."
echo ""
sudo apt-get -y update

echo ""
echo "INSTALLING open-vm-tools..."
echo ""
sudo apt -y install open-vm-tools

echo ""
echo "INSTALLING sslstrip & slowloris & network-manager & gedit ..."
echo ""
sudo apt -y install sslstrip slowloris network-manager gedit

echo ""
echo "INSTALLING openvpn packages..."
echo ""
sudo apt-get install -y openvpn network-manager-openvpn network-manager-openvpn-gnome

echo ""
echo "RESTARTING Network-Manager..."
echo ""
sudo systemctl restart NetworkManager

echo ""
echo ""
echo "ALLOWING ROOT SSH ..."

sudo "PermitRootLogin yes" | sudo tee -a /etc/ssh/sshd_config
#sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
#sudo service ssh restart
#echo "Go to /etc/ssh/sshd_config and look for the line 
#echo "PermitRootLogin no"
#echo "Change the no to yes and restart sshd"
#echo "service ssh restart"
echo "Root Login ALLOWED!"


echo ""
echo "ENABLE ssh..."
echo ""
sudo systemctl enable ssh


echo ""
echo "START ssh..."
echo ""
sudo systemctl start ssh

echo ""
echo "ENABLE autologin on Kali Linux..."
echo ""
sudo mv /etc/gdm3/daemon.conf /etc/gdm3/daemon-OLD.conf
sudo mv kali2021_autologin_files/daemon.conf /etc/gdm3/

echo ""
echo "Grabbing the pcaps directory..."
echo ""
sudo wget  -P /root/Downloads/ https://kryptacademy.s3.us-east-2.amazonaws.com/resources/pcaps.zip
sudo unzip /root/Downloads/pcaps.zip -d /root/Downloads/pcaps.zip
sudo rm /root/Downloads/pcaps.zip
#sudo mv pcaps/ /root/Downloads/


echo ""
echo ""
echo "Moving names.txt TO /root ..."
sudo mv names.txt /root/

echo ""
echo ""
echo "Moving rockyou-75.txt TO /root ..."
sudo mv rockyou-75.txt /root/

echo ""
echo ""
echo "Moving Nessus.txt TO /root ..."
sudo mv Nessus.txt /root/

echo ""
echo ""
echo "Download Nessus 10.0.2 TO /root/Downloads ..."
sudo wget -P /root/Downloads/ https://kryptacademy.s3.us-east-2.amazonaws.com/resources/Nessus-10.0.2-debian6_amd64.deb 

echo ""
echo ""
echo "Installing Nessus ..."
sudo apt install -f /root/Downloads/Nessus-10.0.2-debian6_amd64.deb

echo ""
echo ""
echo "Moving metasploit.txt TO /root ..."
sudo mv metasploit.txt /root/

echo ""
echo ""
echo "Moving Heartbleed TO /root ..."
sudo mv Heartbleed/ /root/Downloads/

echo ""
echo ""
echo "Moving ModesofOperation TO /root ..."
sudo mv ModesofOperation/ /root/Downloads/

echo ""
echo ""
echo "Moving dns2proxy-master TO /root ..."
sudo mv dns2proxy-master/ /root/Downloads/

echo ""
echo ""
echo "Moving hashes TO /root ..."
sudo mv hashes/ /root/

echo ""
echo ""
echo "Moving change_hostname file TO /root/Desktop/ ..."
sudo mv ChangeHostname.txt /root/Desktop/

echo ""
echo ""
echo "Moving README_for_gnome.txt TO /root ..."
sudo mv kali2021_autologin_files/README_for_gnome.txt /root/

echo ""
echo "Current IP Configuration ..."
ifconfig eth0




#echo "Don't forget to set screen resolution to 1360x768"
echo ""
echo ""
echo "TO CHANGE RESOLUTION:"
echo "sudo xrandr -s 1360x768"
echo "OR"
echo "sudo xrandr -s 1280x800"

echo ""
echo ""
echo "Go to: SETTINGS > POWER"
echo "1. Change Blank Screen to Never"
echo "2. Change Automatic Suspend to Off"

echo ""
echo ""
echo "REMOVING MYSELF!"
echo "rm -R ../scripts/"
rm -R ../scripts/

echo ""
echo ""
echo "DON'T FORGET rm ./.zsh_history"
echo "Close this terminal, open a new one, the run rm ./.zsh_history"
rm ./.zsh_history
echo "Then, reboot"
