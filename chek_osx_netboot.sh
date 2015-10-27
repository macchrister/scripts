#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	printf "UNKNOWN - This script must be run as root.\n"
	exit 3
fi

# check that the netboot service is running
NETBOOTStatus=`/Applications/Server.app/Contents/ServerRoot/usr/sbin/serveradmin fullstatus netboot | grep 'netboot:state = ' | sed -E 's/netboot:state = +"(.+)"/\1/'`
TFTPStatus=`/Applications/Server.app/Contents/ServerRoot/usr/sbin/serveradmin fullstatus netboot | grep 'netboot:stateTFTP' | sed -E 's/netboot:stateTFTP.+"(.+)"/\1/'`
HTTPStatus=`/Applications/Server.app/Contents/ServerRoot/usr/sbin/serveradmin fullstatus netboot | grep 'netboot:stateHTTP' | sed -E 's/netboot:stateHTTP.+"(.+)"/\1/'`
NFSStatus=`/Applications/Server.app/Contents/ServerRoot/usr/sbin/serveradmin fullstatus netboot | grep 'netboot:stateNFS' | sed -E 's/netboot:stateNFS.+"(.+)"/\1/'`

if [ "$NETBOOTStatus" != "RUNNING" ]; then
	printf "CRITICAL - NetBoot service is not running!\n"
	exit 2
fi

if [ "$TFTPStatus" != "RUNNING" ]; then
	printf "CRITICAL - TFTP service is not running!\n"
	exit 2
fi

if [ "$HTTPStatus" != "RUNNING" ] && [ "$NFSStatus" != "RUNNING" ] ; then
	printf "CRITICAL - HTTPS or NFS services is not running!\n"
	exit 2
fi
printf "OK – Netboot is working.\n"
exit 0
