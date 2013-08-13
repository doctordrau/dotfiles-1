xrdb ~/.Xresources
xsetroot -cursor_name left_ptr

urxvtd &
sxhkd &

export PANEL_FIFO=~/.panel_fifo
rm -f "$PANEL_FIFO" ; mkfifo "$PANEL_FIFO"
bspwm -s "$PANEL_FIFO" -p W &

# Something about ck-launch-session dbus-launch <wm>, but let's try it normal, maybe /etc/X11/xsession.d will save me..
sleep inf

