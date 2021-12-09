#!/bin/bash

echo "ALLOWING root LOGIN"
sudo apt install -y kali-root-login

echo "SETTING root PASSWORD TO toor"
echo -e "toor\ntoor" | sudo passwd


echo ""
echo "RENEW IP ..."
echo ""
dhclient -r
dhclient
dhclient -r
dhclient

echo ""
echo "INSTALLING open-vm-tools..."
echo ""
sudo apt -y install open-vm-tools

echo ""
echo ""
echo "ALLOWING ROOT SSH ..."
sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
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
echo ""
echo "Moving names.txt UP one directory ..."
sudo mv names.txt /root/


echo ""
echo ""
echo "Moving rockyou-75.txt TO /root ..."
sudo cp rockyou-75.txt /root/Download/
sudo mv rockyou-75.txt /root/

echo ""
echo ""
echo "Moving Heartbleed TO /root ..."
sudo mv Heartbleed/ /root/Download/

echo ""
echo ""
echo "Moving ModesofOperation TO /root ..."
sudo mv ModesofOperation/ /root/Download/

echo ""
echo ""
echo "Moving dns2proxy-master TO /root ..."
sudo mv dns2proxy-master/ /root/Download/

echo ""
echo ""
echo "Moving hashes TO /root ..."
sudo mv hashes/ /root/

echo ""
echo ""
echo "Moving README_for_gnome.txt TO Desktop ..."
sudo mv kali2021_autologin_files/README_for_gnome.txt /root/Desktop/

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
rm ./.zsh_history
echo "Then, reboot"
