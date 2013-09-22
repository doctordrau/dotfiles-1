#!/bin/sh

# tapping settings
opts="$opts TapButton1=1 TapButton2=3 TapButton3=2 TapAndDragGesture=off"

# the sensitivity down a little 
opts="$opts FingerLow=26 FingerHigh=32 PalmDetect=on" 

# two finger scrolling
opts="$opts VertTwoFingerScroll=1 HorizTwoFingerScroll=1"

for x in $opts; do synclient $x ; done


echo 12000 | sudo tee /sys/class/backlight/gmux_backlight/brightness
echo 50 | sudo tee /sys/class/leds/smc::kbd_backlight/brightness
