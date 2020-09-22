#!/bin/bash
str="user"

for i in {100..200}
do
	user="$str$i"
	echo "Adding \"$user\""
	password="$(head /dev/urandom | tr -dc A-Za-z | head -c 13 ; echo '')"
	sudo useradd $user
	echo $user:$password | sudo chpasswd
	echo "$user created successfully"
	echo -e "$user\n$password" | pr -2 -t -s >> users.csv
done
