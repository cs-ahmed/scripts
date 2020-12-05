#!/bin/bash

echo ""
echo "ENABLE ssh..."
echo ""
sudo systemctl enable ssh
sudo systemctl start ssh

echo ""
echo ""
echo "ALLOWING ROOT SSH ..."
sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
sudo service ssh restart
echo ""
echo ""
echo "ALLOWED!"

echo ""
echo ""
echo "DON'T FORGET cd .."
echo "DON'T FORGET rm -R scripts/"

echo ""
echo ""
echo "DON'T FORGET rm ./.bash_history"
echo "Then, reboot  if needed"
