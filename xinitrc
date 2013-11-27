xrdb -merge ~/.Xresources
xset +fp $HOME/.fonts/ansi
xset fp rehash
xsetroot -cursor_name left_ptr

sh ~/bin/macbook-power.sh &

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
killall ssh-agent
eval $(ssh-agent)
ssh-add &

nm-applet &
xscreensaver &
compton --config ~/.compton.conf &
urxvtd -q -o -f
sxhkd &
xfce4-panel -d &
bspwm &

google-chrome --no-startup-window &

# ck-launch-session dbus-launch <wm> if in need of dbus/ck?
sleep inf

