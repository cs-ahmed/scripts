#!/bin/bash
str="user"

for i in {100..200}
do
	user="$str$i"
	sudo userdel -r $user
done
