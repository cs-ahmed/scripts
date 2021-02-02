#!/bin/bash

## SETUP A KALI VM ON ESXI
## NORMAL USE

echo ""
echo "RENEW IP ..."
echo ""
dhclient -r
dhclient
dhclient -r
dhclient

echo ""
echo "CONFIGURING /etc/apt/sources.list ..."
echo ""
sudo echo "deb http://httpredir.debian.org/debian jessie main" >> /etc/apt/sources.list
sudo echo "deb-src http://httpredir.debian.org/debian jessie main" >> /etc/apt/sources.list
sudo echo "" >> /etc/apt/sources.list
sudo echo "deb http://httpredir.debian.org/debian jessie-updates main" >> /etc/apt/sources.list
sudo echo "deb-src http://httpredir.debian.org/debian jessie-updates main" >> /etc/apt/sources.list
sudo echo "" >> /etc/apt/sources.list
sudo echo "deb http://security.debian.org/ jessie/updates main" >> /etc/apt/sources.list
sudo echo "deb-src http://security.debian.org/ jessie/updates main" >> /etc/apt/sources.list
#sudo gedit /etc/apt/sources.list

#deb http://httpredir.debian.org/debian jessie main
#deb-src http://httpredir.debian.org/debian jessie main

#deb http://httpredir.debian.org/debian jessie-updates main
#deb-src http://httpredir.debian.org/debian jessie-updates main

#deb http://security.debian.org/ jessie/updates main
#deb-src http://security.debian.org/ jessie/updates main


echo ""
echo "Running apt-get update..."
echo ""
sudo apt-get update


echo ""
echo "INSTALLING open-vm-tools..."
echo ""
sudo apt -y install open-vm-tools


echo ""
echo ""
echo "Moving names.txt UP one directory ..."
cp names.txt ../Downloads/
mv names.txt ../


echo ""
echo ""
echo "Moving rockyou-75.txt UP one directory ..."
cp rockyou-75.txt ../Downloads/
mv rockyou-75.txt ../


echo ""
echo ""
echo "Moving Heartbleed UP one directory ..."
mv Heartbleed/ ../Downloads/

echo ""
echo ""
echo "Moving ModesofOperation UP one directory ..."
mv ModesofOperation/ ../Downloads/

echo ""
echo ""
echo "Moving dns2proxy-master UP one directory ..."
mv dns2proxy-master/ ../Downloads/


echo ""
echo ""
echo "Moving salt.txt files UP one directory ..."
mv salt1.txt ../
mv salt2.txt ../
mv salt3.txt ../


echo ""
echo "Current IP Configuration ..."
ifconfig eth0

#echo "Don't forget to set screen resolution to 1280x800"
echo ""
echo ""
echo "TO CHANGE RESOLUTION:"
echo "sudo xrandr -s 1360x768"
echo "OR"
echo "sudo xrandr -s 1280x800"

echo ""
echo ""
echo "SET SCREEN AND POWER SETTINGS"

echo ""
echo ""
echo "DON'T FORGET cd .."
echo "DON'T FORGET rm -R scripts/"

echo ""
echo ""
echo "DON'T FORGET rm ./.bash_history"
echo "Then, reboot"
