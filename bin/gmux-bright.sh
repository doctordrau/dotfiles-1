#!/bin/sh

BR_DIR="/sys/class/backlight/gmux_backlight"
BR_MIN=150
BR_MAX=$(<$BR_DIR/max_brightness)
BR_RES=32

br_get () {
    echo $(<$BR_DIR/brightness)
}

br_set () {
    echo "$1" | sudo tee $BR_DIR/brightness
}

br_up () {
    br_set $(expr $(br_get) + $BR_STEP)
    
}

br_down () {
    br_set $(expr $(br_get) - $BR_STEP)
}

br_min () {
    br_set $BR_MIN
}

br_max () {
    br_set $BR_MAX
}

if [ $(br_get) -lt 10000 ]; then
    BR_STEP=100
else
    BR_STEP=$(expr $BR_MAX / $BR_RES)
fi
#echo "step $BR_STEP max $BR_MAX bright $(br_get)" >> /tmp/bright-debug

case "$1" in 
    up)     br_up
    ;;
    down)   br_down 
    ;;
    min)    br_min
    ;;
    max)    br_max
    ;;
    *)
    echo "Usage: remove requiretty from sudoers, vi $0"
    ;;
esac

