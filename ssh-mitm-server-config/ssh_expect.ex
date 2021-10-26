#!/usr/bin/expect -f
# 1st argument: server id
# 2nd argument: current password
# 3rd argument: new password

set server_id [lindex $argv 0];
set current_password [lindex $argv 1];
set new_password [lindex $argv 2];

eval spawn sshpass -p $current_password ssh -o StrictHostKeyChecking=no root@13.13.13.$server_id passwd
expect "word:"
send "$new_password\r"
expect "word:"
send "$new_password\r"
expect eof
