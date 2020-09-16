#!/bin/bash

# https://security.stackexchange.com/questions/147397/hashcat-with-kali-2-in-a-vm
# https://unix.stackexchange.com/questions/592657/full-upgrade-to-debian-testing-fails-due-to-libc6-dev-breaks-libgcc-8-dev

echo ""
echo "UPDATE..."
echo ""
apt update


echo ""
echo "INSTALL libhwloc-dev ocl-icd-dev ocl-icd-opencl-dev ..."
echo ""
sudo apt-get install libhwloc-dev ocl-icd-dev ocl-icd-opencl-dev


echo ""
echo "If you have trouble ..."
echo ""
sudo apt install gcc-8-base

echo ""
echo "INSTALLING pocl-opencl-icd..."
echo ""
apt-get install pocl-opencl-icd


echo "Try running hashcat now!"
echo "--force"