#!/bin/bash
DEVICE="wlo1"
radiostatus=`nmcli radio wifi`
if [ "$radiostatus" = "enabled" ]; then
    list=`nmcli -t device wifi list`
    nlist=`printf "$list" | wc -l`
    result=""
    for n in `seq 1 $nlist`; do
        line=`printf "$list" | sed "${n}q;d"`
        active=`echo "$line" | cut -f "1" -d ":"`
        SSID=`echo "$line" | cut -f "2" -d ":" --output-delimiter " "`
        line=`echo "$line" | cut -f "1,2" -d ":" --output-delimiter " "`
        echo "$SSID"
        if [ "$active" = ' ' ]; then
            result="${result}$line,nmcli device disconnect $DEVICE\n"
        else
            result="${result}$line,^term(nmtui connect $SSID)\n"
        fi
    done
    printf "Connect automatically, nmcli device connect $DEVICE\nAccess points...,^checkout(list)\nAdvanced...,^term(nmtui)\nDisconnect,nmcli device disconnect $DEVICE\nAirplane Mode,nmcli radio wifi off\n^tag(list)\n${result}Rescan, nmcli device wifi rescan\n" | jgmenu --at-pointer --simple
else
    nmcli radio wifi on
fi
