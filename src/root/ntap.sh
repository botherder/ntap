#!/bin/bash

tcpdump -q -s0 -i br0 -n -w /root/dump.pcap &

sleep 5

IF_NAME=eth1

while true
do
    IF_CHECK=$(ifconfig | grep $IF_NAME | awk '{print $1}')

    if [ "$IF_CHECK" = "$IF_NAME" ]; then
        echo "all good..."
    else
        echo "shutting down!"
        shutdown -h now
    fi

    sleep 1
done

