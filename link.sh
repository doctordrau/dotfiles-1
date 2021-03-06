#!/bin/sh -x

cd ~/config
git remote set-url origin git@github.com:sampowers/dotfiles.git

cd ~
[[ -d config ]] || ( echo "dazed and confused" ; exit 0)

mv -f .zshrc .zshrc.orig
ln -s config/zsh/zshrc .zshrc

mv -f .bashrc .bashrc.orig
ln -s config/bash/bashrc .bashrc

mv -f .profile .profile.orig
ln -s config/bash/profile .profile

mv -f .vim .vim.orig
ln -s config/vim/vim .vim

mv -f .vimrc .vimrc.orig
ln -s config/vim/vimrc .vimrc

mv -f .gvimrc .gvimrc.orig
ln -s config/vim/gvimrc .gvimrc

mv -f .fonts .fonts.orig
ln -s config/fonts .fonts

mv -f .screenrc .screenrc.orig
ln -s config/screenrc .screenrc

mv -f .xinitrc .xinitrc.orig
ln -s config/xinitrc .xinitrc

mv -f .Xresources .Xresources.orig
ln -s config/Xresources .Xresources

mv -f .config/bspwm .config/bspwm.orig
ln -s $HOME/config/bspwm .config/bspwm

mv -f .config/sxhkd .config/sxhkd.orig
ln -s $HOME/config/sxhkd .config/sxhkd

mv -f .config/xfce4 .config/xfce4.orig
ln -s $HOME/config/xfce4 .config/xfce4

mv -f .config/lxpanel .config/lxpanel.orig
ln -s $HOME/config/lxpanel .config/lxpanel

mv -f .compton.conf .compton.conf.orig
ln -s config/compton.conf .compton.conf

mv -f .gtkrc-2.0 .gtkrc-2.0.orig
ln -s config/gtkrc-2.0 .gtkrc-2.0

mv -f .themes .themes.orig
ln -s config/gtk.themes .themes


