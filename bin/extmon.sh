#!/bin/sh

# Very simple external monitor handler for thinkpad.

LVDS_W="1280"
LVDS_H="800"
LVDS_RES="${LVDS_W}x${LVDS_H}"

VGA_RES="1024x768"


randr_event_listener () { 
    xev -event randr -root  | \
      while read l; do
        case "$l" in
          *RR_Connected*)     $0 -a ;;
          *RR_Disconnected*)  $0 -r ;;
          #*) echo "wtf $l" ;;
        esac
      done
}

while getopts "ard" OPTION; do
 case "$OPTION" in
    a) xrandr --output LVDS1 --mode "$LVDS_RES" --pos 0x0 \
              --output VGA1 --auto --left-of LVDS1
              # --output VGA1  --mode "$VGA_RES"  --same-as LVDS1
       ;;
    r) xrandr --output VGA1 --off --output LVDS1 --auto
       ;;
    d) randr_event_listener
       ;;
 esac
done


