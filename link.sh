#!/bin/sh -x

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

mv -f .emerald .emerald.orig
ln -s config/emerald .emerald

mv -f .Xresources .Xresources.old
ln -s config/Xresources .Xresources

mv -f .xmobarrc .xmobarrc.old
ln -s config/xmobarrc .xmobarrc
