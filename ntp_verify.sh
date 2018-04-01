#!/bin/bash

ps auxw | grep ntpd | grep -v grep > /dev/null

if [ $(pgrep ntpd)=='0' ]
then
echo "NOTICE: ntp is not running">
  `systemctl start ntp`
fi

diff /etc/ntp.conf /etc/ntp.conf.back-up > /dev/null
if [ $? == 1 ];
then
echo "NOTICE: /etc/ntp.conf was changed. Calculated diff:" >> /var/mail/root

diff -u0 /etc/ntp.conf.back-up /etc/ntp.conf >> /var/mail/root
echo "Restoring ntp.conf and restart ntp server"
cat /etc/ntp.conf.back-up > /etc/ntp.conf
service ntp restart > /dev/null
fi;
