#!/bin/sh
MYUTILS="git zsh vim screen python-virtualenvwrapper"
MYGROUPS="standard base-x fonts"
MYDESKTOP="slim rxvt-unicode-256color trayer xorg-x11-fonts-100dpi firefox"
BSPWM_DEPS="libxcb-devel libxcb xcb-util xcb-util-wm xcb-util-devel xcb-util-wm-devel xcb-util-keysyms-devel"
RICE="dzen2 conky"

sudo yum update -y audit
sudo yum install -y $MYUTILS
sudo yum group install -y $MYGROUPS
sudo yum install -y $MYDESKTOP
sudo yum install -y $BSPWM_DEPS
# clone & compile bspwm here...
sudo yum install -y $RICE

sudo yum install -y http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm
sudo yum install -y freetype-infinality infinality-settings

# cp slim.conf /etc/slim.conf
sudo systemctl enable slim.service
sudo ln -sf /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target # might need a reboot
sudo yum update kernel
read -p "Reboot?" && sudo systemctl reboot

if [ $NVIDIA ]; then
    yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm
    yum install -y akmod-nvidia xorg-x11-drv-nvidia-libs
    yum install -y vdpauinfo libva-vdpau-driver libva-utils
fi
