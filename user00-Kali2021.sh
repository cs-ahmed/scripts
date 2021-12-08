#!/bin/bash

echo "SETTING root PASSWORD TO toor"
echo -e "toor\ntoor" | sudo passwd

echo ""
echo "Install gedit ..."
echo ""
apt install -y gedit


echo ""
echo "RENEW IP ..."
echo ""
dhclient -r
dhclient
dhclient -r
dhclient

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
mv /etc/lightdm/lightdm.conf /etc/lightdm/lightdm-OLD.conf
mv kali2021_autologin_files/lightdm.conf /etc/lightdm/
mv /etc/pam.d/lightdm-autologin /etc/pam.d/lightdm-autologin-OLD
mv kali2021_autologin_files/lightdm-autologin /etc/pam.d/


echo ""
echo ""
echo "Moving names.txt UP one directory ..."
mv names.txt /root/


echo ""
echo ""
echo "Moving rockyou-75.txt UP one directory ..."
cp rockyou-75.txt /root/Downloads/
mv rockyou-75.txt /root/


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
echo "DON'T FORGET cd .."
echo "DON'T FORGET rm -R scripts/"
rm -R ../scripts/

echo ""
echo ""
echo "DON'T FORGET rm ./.bash_history"
rm ./.bash_history
echo "Then, reboot"
