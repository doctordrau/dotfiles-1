#!/bin/sh
BAT=$(</sys/class/power_supply/BAT0/status)
CAP=$(</sys/class/power_supply/BAT0/capacity)
LIMIT=5
SUSPEND="/usr/sbin/pm-suspend-hybrid"

if [[ "$BAT" = "Discharging" && $CAP -le $LIMIT ]]; then
    logger "$0: suspending (${SUSPEND}) because capacity is below ${LIMIT}"
    sudo $SUSPEND
fi
