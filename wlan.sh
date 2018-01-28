#!/bin/bash

wlanarg=$1

wpafolder="/etc/wpa_supplicant"
wpafile="${wpafolder}/wpa_no_mobile.conf"
#wpa_extra_parameters=""

if [[ $1 == "help" ]]
then
    echo "usage:"
    echo "wlan.sh all       : wpa.conf with all available connections"
    echo "wlan.sh config1   : use conf forcing ssid1"
    echo "wlan.sh config2   : use conf forcing ssid2"
    exit
fi

#force connection due to parameters in call
if [[ $wlanarg == "all" ]]
then
    echo "use wpa.conf containing all possible configured connections"
    wpafile="${wpafolder}/wpa_all.conf"
elif [[ $wlanarg == "config1" ]]
then
    echo "force connection to syburg via syburg.conf"
    wpafile="${wpafolder}/config1.conf"
elif [[ $wlanarg == "config2" ]]
then
    echo "force connection to linda's hotspot via linda_handy.conf"
    wpafile="${wpafolder}/config2.conf"
else
    echo "use standard wpa_no_mobile.conf file searching for the best connection"
fi

sudo pkill dhcpcd
sudo pkill wpa_supplicant
sleep 1
echo "wpa_supplicant..."
sudo wpa_supplicant -B -i wlp3s0 -c $wpafile #$wpa_extra_parameters
echo "dhcpcd..."
sudo dhcpcd
