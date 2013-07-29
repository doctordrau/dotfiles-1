#!/bin/sh
MYUTILS="git zsh vim screen"
MYGROUPS="standard base-x"
MYDESKTOP="slim xmonad xmobar rxvt-unicode-256color trayer xorg-x11-fonts-100dpi firefox"

sudo yum update -y audit
sudo yum install -y $MYUTILS
sudo yum group install -y $MYGROUPS
sudo yum install -y $MYDESKTOP

sudo yum update kernel
yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm
yum install akmod-nvidia xorg-x11-drv-nvidia-libs
yum install vdpauinfo libva-vdpau-driver libva-utils
