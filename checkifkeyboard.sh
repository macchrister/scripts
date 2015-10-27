#!/bin/bash

KEYBOARD=`ioreg -p IOUSB |grep -o 'Apple Keyboard'`
HOST_NAME=`scutil --get HostName`

if [ "$KEYBOARD" != "Apple Keyboard" ]; then
	echo "$HOST_NAME" |  mail -s "No Keyboard found on $HOST_NAME" post@to.me
fi
exit 0
