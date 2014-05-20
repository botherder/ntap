#!/bin/bash

set -e

logfile=/root/ntap.log
exec > $logfile 2>&1

failsafe(){
    sleep 10
    shutdown -h now
}

trap failsafe EXIT TERM INT

rm -f /root/dump.pcap

tcpdump -q -s0 -i br0 -n -w /root/dump.pcap -C 20 &

sleep 5

IF_NAME=eth1

while true
do
    IF_CHECK=$(ifconfig | grep $IF_NAME | awk '{print $1}')

    if [ ! "$IF_CHECK" = "$IF_NAME" ]; then
        echo "shutting down!"
        exit
    fi

    sleep 1
done

