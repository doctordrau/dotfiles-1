xrdb -merge ~/.Xresources
xset +fp $HOME/.fonts/ansi
xset fp rehash
xsetroot -cursor_name left_ptr

xscreensaver &
compton --config ~/.compton.conf &
urxvtd &
sxhkd &
xfce4-panel -d &
bspwm &

# ck-launch-session dbus-launch <wm> if in need of dbus/ck?
sleep inf

