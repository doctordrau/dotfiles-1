#!/bin/bash
pollinterval=30

# Batt % and status (100% +) (99% -)
# CPU Temp (32F)

function garp () {
    grep $1 /proc/pmu/$2 | cut -d: -f 2
}

function poll () {
  
    cha=$(garp ^charge battery_0)
    max=$(garp ^max_cha battery_0)
    batt_pct=$(echo "$cha /$max * 100"|bc -l | xargs printf "%1.0f")
    [ $(garp ^AC info) != 0 ] && chargin="+" || chargin="-"
    temp=$(</sys/devices/temperatures/sensor1_temperature)
    fan=$(cat /sys/devices/temperatures/sensor1_fan_speed | cut -d' ' -f 2-3)
    batt="[$chargin $batt_pct%]"
}

i3status | while :; do
    read i3stat
    test $((i++ % $pollinterval)) -eq 0 && poll
    echo "${temp}C $fan | $i3stat | $batt"

done
