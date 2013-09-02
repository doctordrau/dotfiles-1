xrdb -merge ~/.Xresources
xset +fp $HOME/.fonts/ansi
xset fp rehash
xsetroot -cursor_name left_ptr

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
eval $(ssh-agent)
ssh-add &

xscreensaver &
compton --config ~/.compton.conf &
urxvtd -q -o -f
sxhkd &
xfce4-panel -d &
bspwm &
sleep 1; wmname LG3D

# ck-launch-session dbus-launch <wm> if in need of dbus/ck?
sleep inf

