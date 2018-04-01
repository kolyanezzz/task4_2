#/bin/bash

apt-get install -y ntp

sed -i "/0.ubuntu.pool.ntp.org/d" /etc/ntp.conf
sed -i "/1.ubuntu.pool.ntp.org/d" /etc/ntp.conf
sed -i "/2.ubuntu.pool.ntp.org/d" /etc/ntp.conf
sed -i "/3.ubuntu.pool.ntp.org/d" /etc/ntp.conf
if grep -q "pool ua.pool.ntp.org" /etc/ntp.conf
  then :
else
sed -i "17i pool ua.pool.ntp.org" /etc/ntp.conf
fi
systemctl restart ntp

cp /etc/ntp.conf /etc/ntp.conf.back-up

crontab <<EOF
* * * * * `pwd`/ntp_verify.sh >/dev/null 2>&1
EOF

