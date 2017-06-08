#!/bin/bash
MAX=90
PART1=sda1
PART2=sda3
PART3=tmpfs
MP1=/
MP2=/tmp
MP3=/dev/shm
HOST=`hostname -a`"("`hostname -i`")"

#CHECKING SDA1
USG=$(df $MP1 | grep $PART1 | awk '{ print $5}' | sed 's/%//g')
if [ $USG -gt $MAX ]; then
#CONNECTING TO SMSDB
sqlplus -s '<<your_user>>@<<your_SID>>/<<your password>>' << EOF
exec SMS_PORTAL.MAIN_SMS_ALERT('WARNING $HOST on $PART1 partitionunda yer $USG % dolmushdur')
EOF
fi

#CHECKING SDA3
USG2=$(df $MP2 | grep $PART2 | awk '{ print $5}' | sed 's/%//g')
if [ $USG2 -gt $MAX ]; then
#CONNECTING TO SMSDB
sqlplus -s '<<your_user>>@<<your_SID>>/<<your password>>' << EOF
exec SMS_PORTAL.MAIN_SMS_ALERT('WARNING $HOST-nin $PART2 partitionunda yer $USG2 % dolmushdur')
EOF
fi

#CHECKING TMPFS
USG3=$(df $MP3 | grep $PART3 | awk '{ print $5}' | sed 's/%//g')
if [ $USG3 -gt $MAX ]; then
#CONNECTING TO SMSDB
sqlplus -s '<<your_user>>@<<your_SID>>/<<your password>>' << EOF
exec SMS_PORTAL.MAIN_SMS_ALERT('WARNING $HOST-nin $PART3 partitionunda yer $USG3 % dolmushdur')
EOF
fi
