#!/bin/bash
sleep 30
counter=0 
echo $counter > ~/Desktop/Vancouverlog.txt
echo $(date) >> ~/Desktop/Vancouverlog.txt
while :
do
	#i=1
	#echo "$i"
	((counter++))
	echo "BEGINNING OF COUNTER $counter" >> ~/Desktop/Vancouverlog.txt
	
	echo "Trying to connect to Vancouver..." >> ~/Desktop/Vancouverlog.txt
	nmcli con up id Vancouver | tee -a ~/Desktop/Vancouverlog.txt
	
	echo "Connected to Vancouver" >> ~/Desktop/Vancouverlog.txt
	
	echo $(date) >> ~/Desktop/Vancouverlog.txt
	sleep 60
	
	echo "Trying to disconnect from Vancouver..." >>~/Desktop/Vancouverlog.txt
	nmcli con down id Vancouver | tee -a ~/Desktop/Vancouverlog.txt
	
	echo "Disconnected from Vancouver" >> ~/Desktop/Vancouverlog.txt
	
	echo $(date) >> ~/Desktop/Vancouverlog.txt
	
	echo "Will sleep for 3 minutes (180 seconds)" >> ~/Desktop/Vancouverlog.txt
	echo "END OF COUNTER $counter" >> ~/Desktop/Vancouverlog.txt
	echo "= = = = = =" >> ~/Desktop/Vancouverlog.txt
	echo "= = = = = =" >> ~/Desktop/Vancouverlog.txt
	echo "= = = = = =" >> ~/Desktop/Vancouverlog.txt
	if [ $counter -eq 20 ]; then
		last_line_of_reboot_log=$(tail -n 1 ~/Desktop/Rebootlog.txt)
		echo "= = = = = =" >> ~/Desktop/Rebootlog.txt
		echo $(date) >> ~/Desktop/Rebootlog.txt
		echo $(date) > ~/Desktop/LastRebootInfo.txt
		echo "Counter reached 20, rebooting..." | tee -a ~/Desktop/Rebootlog.txt
		echo "Counter reached 20, rebooting..." | tee -a ~/Desktop/LastRebootInfo.txt 
		if [[ $last_line_of_reboot_log =~ ^[0-9]+$ ]]; then
			((last_line_of_reboot_log++))			
			echo $last_line_of_reboot_log  >> ~/Desktop/Rebootlog.txt
			echo $last_line_of_reboot_log  >> ~/Desktop/LastRebootInfo.txt
		else
			echo 1  >> ~/Desktop/Rebootlog.txt
			echo 1  >> ~/Desktop/LastRebootInfo.txt
		fi
		sudo reboot
	fi
	#[ $counter -eq 20 ] && sudo reboot | tee -a ~/Desktop/Vancouverlog.txt
	sleep 180
done
