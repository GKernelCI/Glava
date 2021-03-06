#!/bin/sh

#check for root
BEROOT=""
if [ $(id -u) -ne 0 ];then
	BEROOT="sudo "
fi
$BEROOT rm /etc/udev/rules.d/*lavaworker-udev*rules
$BEROOT cp udev/*lavaworker-udev*rules /etc/udev/rules.d/
$BEROOT udevadm control --reload-rules || exit $?
$BEROOT udevadm trigger || exit $?

docker-compose build || exit 1
docker-compose up -d || exit 1
