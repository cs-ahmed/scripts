#!/bin/bash

# wget www.cs.virginia.edu/ibrahim/shared/scripts/amsterdam-capstone-script.sh
# chomd +x amsterdam-capstone-script.sh

# Setting favorites bar apps
#echo "Setting favorites bar apps..."
#sleep 2
#sudo gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop', 'org.gnome.gedit.desktop', 'firefox.desktop',  'thunderbird.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'gnome-control-center.desktop']"
#sudo echo "ENTER PASSWORD"
echo ""
echo "INSTALLING net-tools..."
echo ""
sudo apt-get -y install net-tools

echo ""
echo "RELEASING DHCP lease..."
echo ""
sudo dhclient -r
sleep 5
sudo dhclient -r
sleep 5
echo ""
echo "RENEWING DHCP lease..."
echo ""
sudo dhclient
sleep 5
sudo dhclient
sleep 5

echo ""
echo "Running apt-get update..."
echo ""
sudo apt-get update

#echo ""
#echo "Running apt-get upgrade..."
#echo ""
#sudo apt upgrade -y

echo ""
echo "INSTALLING openssh-server..."
echo ""
sudo apt -y install openssh-server
# reconfigure ssh keys
echo ""
echo "Reconfigure SSH keys..."
echo ""
sudo rm /etc/ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server

# Vino for VNC
echo ""
echo "CHECKING Vino for VNC..."
echo ""
gsettings get org.gnome.Vino require-encryption
echo ""
echo "SETTING Vino for VNC to FALSE..."
echo ""
sudo gsettings set org.gnome.Vino require-encryption false
echo ""
echo "CHECKING Vino for VNC after update!!! Should be false"
echo ""
gsettings get org.gnome.Vino require-encryption
echo "DON'T FORGET TO ENABLE SCREEN SHARING!"

# Install git
# https://www.digitalocean.com/community/tutorials/how-to-install-git-on-ubuntu-18-04-quickstart
echo ""
echo "INSTALLING GIT..."
echo ""
sudo apt -y install git
echo "DONE"

# Apache
echo ""
echo "INSTALLING Apache..."
echo ""
sudo apt -y install apache2

# Remove default python 2 and change the default to python 3 with the 'update-alternatives' command
echo ""
echo "Removing python2..."
sudo update-alternatives --remove python /usr/bin/python2
echo "Installing python3..."
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
echo "Installing pip3..."
sudo apt-get -y install python3-pip
sudo ln -s /usr/bin/pip3 /usr/bin/pip

echo "Installing virtual environment..."
pip install virtualenv
sudo apt -y install virtualenv

# Setting favorites bar apps
echo "Setting favorites bar apps AGAIN..."
sudo gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop', 'org.gnome.gedit.desktop', 'firefox.desktop',  'thunderbird.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'gnome-control-center.desktop']"

sudo rm ./.bash_history

echo "=========================="
echo "=========================="
echo "=========================="
echo "To check the correct installation of pip3,"
echo "type:  which pip3"
echo "you should get:"
echo "/usr/bin/pip3"
echo "=========================="
echo "=========================="
echo "=========================="
echo "Don't forget to set screen resolution to 1280x800"
echo "DON'T FORGET TO ENABLE SCREEN SHARING!"
