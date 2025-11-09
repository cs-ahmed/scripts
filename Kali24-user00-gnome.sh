#!/bin/bash


## CURRENTLY IN USE WITH KALI 2024

echo ""
echo "UPDATE KALI KEY..."
echo "kali" | sudo -S wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add
# sudo -S: The -S option tells sudo to read the password from standard input instead of prompting for it interactively.

echo ""
echo "SUDO APT UDATE..."
echo ""
sudo apt-get -y update


echo "ENABLE root LOGIN"
sudo apt install -y kali-root-login ##&& sudo dpkg-reconfigure kali-grant-root

echo "SETTING root PASSWORD TO toor"
echo -e "toor\ntoor" | sudo passwd

#sudo apt -y install isc-dhcp-client isc-dhcp-client-ddns
 
echo ""
echo "RENEW IP ..."
echo "(1) dhclient -r"
sudo dhclient -r
sleep 5
echo "(1) dhclient"
sudo dhclient
echo "(2) dhclient -r"
sudo dhclient -r
sleep 5
echo "(2) dhclient"
sudo dhclient

echo ""
echo "SUDO APT UDATE..."
echo ""
sudo apt-get -y update

echo ""
echo "INSTALLING open-vm-tools..."
echo ""
sudo apt -y install open-vm-tools open-vm-tools-desktop

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

#echo ""
#echo "Grabbing the gnome.desktop extension..."
#sudo wget -P /root/Downloads/ https://kryptacademy.s3.us-east-2.amazonaws.com/resources/org.gnome.desktop-icons-enhanced.v5.shell-extension.zip
#sudo gnome-extensions install /root/Downloads/org.gnome.desktop-icons-enhanced.v5.shell-extension.zip

echo ""
echo "Grabbing Google Chrome..."
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
echo "Installing Google Chrome..."
# NOT WORKING: sudo apt -y install google-chrome-stable
sudo apt -y install ./google-chrome-stable_current_amd64.deb
sudo rm ./google-chrome-stable_current_amd64.deb

echo ""
echo "Grabbing the pcaps directory..."
echo ""
sudo wget -P /root/Downloads/ https://kryptacademy.s3.us-east-2.amazonaws.com/resources/pcaps.zip
sudo unzip /root/Downloads/pcaps.zip -d /root/Downloads/
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
sudo dpkg -i /root/Downloads/Nessus-10.0.2-debian6_amd64.deb
#sudo apt install -f /root/Downloads/Nessus-10.0.2-debian6_amd64.deb

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
echo "Moving dns2proxy-master TO /root/Downloads/ ..."
sudo mv dns2proxy-master/ /root/Downloads/

echo ""
echo ""
echo "Moving hashes TO /root ..."
sudo mv hashes/ /root/

echo ""
echo ""
echo "Moving change_hostname file TO /root/Downloads/ ..."
sudo mv CHANGE_HOSTNAME.txt /root/Downloads/

echo ""
echo ""
echo "Moving README_for_gnome.txt TO /root ..."
sudo mv kali2021_autologin_files/README_for_gnome.txt /root/

echo ""
echo "Current IP Configuration ..."
ifconfig eth0

echo ""
echo ""
echo "Moving xrandr.sh TO /root/Downloads/ ..."
sudo mv xrandr.sh /root/Downloads/

#echo ""
#echo "Fixing Cursor Problem..."
#sudo mkdir -p /etc/X11/xorg.conf.d
#sudo touch /etc/X11/xorg.conf.d/20-vmware.conf
#echo 'Section "Device"' >> /etc/X11/xorg.conf.d/20-vmware.conf
#echo 'Identifier "VMware SVGA"' >> /etc/X11/xorg.conf.d/20-vmware.conf
#echo 'Driver "vmware"' >> /etc/X11/xorg.conf.d/20-vmware.conf
#echo 'Option "HWCursor" "off"' >> /etc/X11/xorg.conf.d/20-vmware.conf
#echo 'EndSection' >> /etc/X11/xorg.conf.d/20-vmware.conf


#echo "Don't forget to set screen resolution to 1360x768"
#echo ""
#echo ""
#echo "TO CHANGE RESOLUTION:"
#echo "sudo xrandr -s 1360x768"
#echo "OR"
#echo "sudo xrandr -s 1280x800"

#echo ""
#echo ""
#echo "Setting up 1360x768 resolution ..."
#sudo cvt 1360 768
#sudo xrandr --newmode "1360x768_60.00" 85.50 1360 1432 1568 1776 768 771 781 798 -hsync +vsync
#sudo xrandr --addmode Virtual1 "1360x768_60.00"
#sudo xrandr --output Virtual1 --mode "1360x768_60.00"
#echo "Should not see any errors above this line!"

echo ""
echo ""
echo "Go to: SETTINGS > POWER"
echo "1. Change Blank Screen to Never"
echo "2. Change Automatic Suspend to Off"

## TEST
sudo gsettings set org.gnome.desktop.session idle-delay 0
sudo gsettings set org.gnome.desktop.screensaver lock-enabled false

echo ""
echo ""
echo "REMOVING MYSELF!"
echo "rm -R ../scripts/"
rm -R ../scripts/

echo ""
echo ""
echo "DON'T FORGET rm ./.zsh_history"
echo "Close this terminal, open a new one, then run rm ./.zsh_history"
rm ./.zsh_history
echo "Then, reboot"
