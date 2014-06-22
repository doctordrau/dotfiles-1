xrdb -merge ~/.Xresources
xset +fp $HOME/.fonts/ansi
xset fp rehash
xsetroot -cursor_name left_ptr

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
killall ssh-agent
eval $(ssh-agent)
ssh-add &

bspwm &
sxhkd &

mate-panel &
mate-power-manager &
mate-settings-daemon &
xscreensaver &
nm-applet &
google-chrome --no-startup-window &

# ck-launch-session dbus-launch <wm> if in need of dbus/ck?
sleep inf
