xrdb -merge ~/.Xresources
xset +fp $HOME/.fonts/ansi
xset fp rehash
xsetroot -cursor_name left_ptr

# xinput list, xinput list-props 11, prop 267 = Synaptics Scrolling Distance
xinput set-prop 11 267 255 255

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
killall ssh-agent
eval $(ssh-agent)
ssh-add &

bspwm &
sxhkd -f 50 &

mate-panel &
mate-power-manager &
/usr/libexec/mate-settings-daemon &
xscreensaver &
nm-applet &
google-chrome --no-startup-window &
dbus-launch tomboy &

# ck-launch-session dbus-launch <wm> if in need of dbus/ck?
sleep inf
