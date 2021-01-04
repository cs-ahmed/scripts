# scripts

This repo includes scripts for setting up machines

### user00-Kali2018.sh

This script is used to setup a Kali2018 VM to be ready for usage in a WiFi Hacking ESXi environment. 
1) "cd scripts" 
2) run "./user00-Kali2018.sh"
3) wait until it finishs working

### BAND-hostapd.conf

This configuration file can be used to create a 5GHz WiFi network called "BAND" such that students can practice scanning for 5GHz networks.
1) Run: sudo echo "deb http://http.kali.ord/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
2) Run: sudo apt-get -y install hostapd
3) Run: airmon-ng check kill
4) OPTIONAL: Change the 'bssid' and 'channel' in the .conf file if needed
5) Run: hostapd ./BAND-hostapd.conf &

### Useful link:

https://null-byte.wonderhowto.com/how-to/set-up-headless-raspberry-pi-hacking-platform-running-kali-linux-0176182/
