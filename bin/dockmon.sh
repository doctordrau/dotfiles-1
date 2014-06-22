#!/bin/sh
# Very simple external monitor handler for thinkpad.

LVDS_W="1280"
LVDS_H="800"
LVDS_RES="${LVDS_W}x${LVDS_H}"
XVT=2
export DISPLAY=:0.0

pre_switch () {
    sudo chvt $XVT
    sleep 2
}

post_switch () {
    sleep 2
    ~/config/bspwm/bspwmrc
}

dock_connect () {
    pre_switch
    xrandr --output DP1   --auto \
           --output LVDS1 --off
    post_switch
}

dock_disconnect () {
    pre_switch

    # after undocking, sometimes we end up with DP1 disconnected but Screen0 still has a res > LVDS1's maximum res, and we need to explicitly specify a mode.
    xrandr --output LVDS1 --mode "$LVDS_RES" \
           --output DP1   --off
    post_switch
}

projector_connect () {
    pre_switch
    xrandr --output LVDS1 --mode "$LVDS_RES" --pos 0x0 \
           --output VGA1 --auto --left-of LVDS1
    post_switch
}

projector_disconnect () {
    pre_switch
    xrandr --output VGA1 --off \
           --output LVDS1 --auto
    post_switch
}

randr_event_listener () { 
    xev -event randr -root  | \
      while read l; do
        echo "$l" >> /tmp/randrhandlr.log
        case "$l" in
          *RR_Connected*)     randr_state_changed connect    "$l" ;;
          *RR_Disconnected*)  randr_state_changed disconnect "$l" ;;
        esac
      done
}

#       Lap Dock Mir Vga
# dp         X
# vga             X   X
# lvds   X        X
# open   X   ?    X
# onAC       X

on () {
    xrandr -q | grep ' connected' | grep $1
}

off () {
    xrandr -q | grep ' disconnected' | grep $1
}

set_profile () {
    case "$1" in
        lap) dock_disconnect  ;;
        dock) dock_connect ;;
        mir)  projector_connect ;;
    esac
}

randr_state_changed ()  {
    echo "xrandr state changed"
    case "$1" in
        connect*) echo "got xrandr connect" ;;
        disconnect*) echo "got xrandr disconnect" ;;
    esac
 
    # add lid state to table
    ( on LVDS1 && off VGA1 && off DP1 ) && t=lap
    ( on DP1 ) && t=dock
    ( on VGA1 ) && t=mir
    # need vgaonly profile

    echo "i guess we are setting profile $t"

    set_profile $t


}

xtreme_handlr () {
    echo "starting the randr handlr"
    randr_event_listener &

    # handle changes when we missed the randr event

    while :; do
        echo "probing xrandr for change"
        [[ ! -f /tmp/xrandr-state ]] && xrandr -q > /tmp/xrandr-state
        xrandr -q | diff /tmp/xrandr-state - || \
            randr_state_changed

        xrandr -q > /tmp/xrandr-state
        sleep 5
    done
        
}









while getopts "DdPpRx" OPTION; do
 case "$OPTION" in
    D) dock_connect ;;
    d) dock_disconnect ;;
    P) projector_connect ;;
    p) projector_disconnect ;;
    R) randr_event_listener ;;
    x) xtreme_handlr ;;
    *) usage ; tail -20 $0 ; exit 1 ;;
 esac
done
