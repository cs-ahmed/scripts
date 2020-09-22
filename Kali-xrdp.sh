#!/bin/bash


echo ""
echo "Type in your password..."
echo ""
sudo -i


echo ""
echo "CONFIGURING /etc/apt/sources.list  for xrdp ..."
echo ""
sudo echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
apt-key adv --keyserver hkp://keys.gnupg.net --recv-keys 7D8D0BF6
apt update

echo ""
echo "UPDATE and UPGRADE ..."
echo ""
sudo apt-get update && apt-get upgrade

echo ""
echo "INSTALLING xrdp..."
echo ""
apt-get install xrdp


echo "TO START XRDP, TYPE"
echo "service xrdp start"
echo "service xrdp-sesman start"
echo "TO CHECK XRDP IS LISTENING, TYPE"
echo "sudo netstat -tulpn | grep LISTEN"
