#!/bin/bash

echo ""
echo "ENABLE autologin on Kali Linux..."
echo ""
sudo echo "AutomaticLoginEnable = true" >> /etc/gdm3/daemon.conf
sudo echo "AutomaticLogin = root" >> /etc/gdm3/daemon.conf

## Add dictionary files to user00-Kali2018 VMs

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



echo ""
echo ""
echo "SET SCREEN AND POWER SETTINGS"

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
