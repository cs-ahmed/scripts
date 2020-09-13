#!/bin/bash

echo ""
echo "Type in your password..."
echo ""
sudo -i

echo ""
echo "CONFIGURING /etc/apt/sources.list ..."
echo ""
sudo echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list
sudo echo "deb http://httpredir.debian.org/debian jessie main" > /etc/apt/sources.list
sudo echo "deb-src http://httpredir.debian.org/debian jessie main" > /etc/apt/sources.list
sudo echo "" > /etc/apt/sources.list
sudo echo "deb http://httpredir.debian.org/debian jessie-updates main" > /etc/apt/sources.list
sudo echo "deb-src http://httpredir.debian.org/debian jessie-updates main" > /etc/apt/sources.list
sudo echo "" > /etc/apt/sources.list
sudo echo "deb http://security.debian.org/ jessie/updates main" > /etc/apt/sources.list
sudo echo "deb-src http://security.debian.org/ jessie/updates main" > /etc/apt/sources.list
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

#echo "Don't forget to set screen resolution to 1280x800"