#!/bin/bash
str="user"

for i in {1..40}
do
	user="$str$i"
	sudo userdel -r $user
done
