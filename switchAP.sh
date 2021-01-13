#!/bin/bash

# pre install for this script

#ln -s /tmp/link.network /etc/systemd/network/link.network
# apt install hostapd
# cp  hostapd.conf /etc/hostapd/hostapd.conf

# not  needed
#/etc/systemd/resolv.conf : DNSStubListener=no

#sudo create_ap --stop wlan0
sudo ip link set wlan0 down
if [[ "$1" == "ap" ]]; then
    echo 'switch to ap'
    cp AP.network /tmp/link.network
    sudo systemctl restart systemd-networkd.service
    sudo systemctl stop dhcpcd
    sudo systemctl stop wpa_supplicant.service
    sudo systemctl restart hostapd.service

else
    echo 'switch to client'
    cp Client.network /tmp/link.network
    sudo systemctl stop hostapd.service
    sudo systemctl restart dhcpcd
    sudo systemctl start wpa_supplicant.service
    sudo systemctl restart systemd-networkd.service
fi

sudo ip link set wlan0 up
sudo iw wlan0 info
ifconfig wlan0
# rw

# show current
