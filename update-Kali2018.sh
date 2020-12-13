#!/bin/bash


echo ""
echo ""
echo "ALLOWING ROOT SSH ..."
sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "ALLOWED!"
sudo service ssh restart


echo ""
echo "ENABLE ssh..."
echo ""
sudo systemctl enable ssh


echo ""
echo "START ssh..."
echo ""
sudo systemctl start ssh

echo ""
echo ""
echo "Moving names.txt UP one directory ..."
mv names.txt ../

#echo "Don't forget to set screen resolution to 1280x800"
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

echo ""
echo ""
echo "DON'T FORGET rm ./.bash_history"
echo "Then, reboot"
