xrdb ~/.Xresources
xsetroot -cursor_name left_ptr

compton --config ~/.compton.conf &
urxvtd &
sxhkd &

export PANEL_FIFO=~/.panel_fifo
rm -f "$PANEL_FIFO" ; mkfifo "$PANEL_FIFO"
bspwm -s "$PANEL_FIFO" -p W &

# ck-launch-session dbus-launch <wm> if in need of dbus/ck?
sleep inf

