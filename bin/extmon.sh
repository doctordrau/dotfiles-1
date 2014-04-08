#!/bin/sh

LVDS_W="1280"
LVDS_H="800"
LVDS_RES="${LVDS_W}x${LVDS_H}"

VGA_RES="1024x768"

randr_event_handler () {
    echo "randr_handlr: $1"
}

randr_event_listener () { 
    xev -event randr -root | while read RANDR_EVENT; do
        randr_event_handler "$RANDR_EVENT"
    done
}

while getopts "ard" OPTION; do
 case "$OPTION" in
    a) xrandr --output LVDS1 --mode "$LVDS_RES" --pos 0x0 \
              --output VGA1  --mode "$VGA_RES"  --same-as LVDS1
       ;;
    r) xrandr --output VGA1 --off
       ;;
    d) randr_event_listener
       ;;
 esac
done


