#!/bin/bash
str="user"

for i in {41..70}
do
	user="$str$i"
	echo "Adding \"$user\""
	password="$(head /dev/urandom | tr -dc A-Za-z | head -c 5 ; echo '')"
	sudo useradd $user --create-home
	echo $user:$password | sudo chpasswd
	echo "$user created successfully"
	echo -e "$i\n$user\n$password" | pr -3 -t -s >> users.csv
	./ssh_expect.ex $i toor $password
	#exit
done
