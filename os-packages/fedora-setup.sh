#!/bin/sh

MYUTILS="git zsh vim screen python-virtualenvwrapper"
MYGROUPS="standard base-x"
MYDESKTOP="slim rxvt-unicode-256color xfce4-panel xfce4-weather-plugin xfce4-mailwatch-plugin xfce4-datetime-plugin xfce4-mpc-plugin xfce4-timer-plugin"
MYDESKTOP_FONTS="terminus-fonts google-droid-sans-fonts google-droid-serif-fonts google-droid-sans-mono-fonts "
MYDESKTOP_APPS="firefox mpd mpc ncmpcpp"

BSPWM_DEPS="libxcb-devel libxcb xcb-util xcb-util-wm xcb-util-devel xcb-util-wm-devel xcb-util-keysyms-devel"

sudo yum update -y audit # fixup for nvidia or something
sudo yum update -y

sudo yum install -y $MYUTILS
sudo yum group install -y $MYGROUPS

sudo yum install -y $MYDESKTOP $MYDESKTOP_FONTS $MYDESKTOP_APPS

sudo yum install -y $BSPWM_DEPS
# Then compile and install bspwm/sxhkd

sudo yum install -y http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm
sudo yum install -y freetype-infinality infinality-settings


if [ $NVIDIA ]; then
    yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm
    yum install -y akmod-nvidia xorg-x11-drv-nvidia-libs
    yum install -y vdpauinfo libva-vdpau-driver libva-utils
fi


# cp $CONFIG_DIR/os/slim.conf /etc/slim.conf
sudo systemctl enable slim.service
sudo ln -sf /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target # might need a reboot

sudo yum update kernel
read -p "Reboot?" && sudo systemctl reboot
