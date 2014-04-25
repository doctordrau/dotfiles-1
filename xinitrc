xrdb -merge ~/.Xresources
xset +fp $HOME/.fonts/ansi
xset fp rehash
xsetroot -cursor_name left_ptr

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
killall ssh-agent
eval $(ssh-agent)
ssh-add &

bspwm &
sxhkd &

lxpanel &
xscreensaver &
nm-applet &

google-chrome --no-startup-window &
~/bin/extmon.sh -d &


# ck-launch-session dbus-launch <wm> if in need of dbus/ck?
sleep inf

