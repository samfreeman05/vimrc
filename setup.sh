#!/bin/bash

# Setup for Dotfiles

pkg="i3-gaps i3blocks ranger arandr rxvt-unicode w3m rofi feh wmctrl imagemagick"

#mkdir ~/.scripts
#mkdir ~/.screenlayout
[ ! -d ~/.dotfiles.old ] && mkdir ~/.dotfiles.old

usage() {
    echo "Usage: $0 [-s]" 1>&2
    echo "      -s Skips the package installation"
    exit 1
}
while getopts ":sh" o; do
	case "${o}" in
	s)
                # Skip the package installation
		s=true
	;;
	h)
		usage
	;;
	esac
done

if [ -z ${s} ]
then
    read -p "Enter your package manager's install command: " installCommand
    eval ${installCommand} ${pkg}
fi

# Link Dotfiles
# .bashrc.aliases .Xresources

[ -f ~/.bashrc.aliases ] && mv ~/.bashrc.aliases ~/.dotfiles.old/
ln -s ~/Dotfiles/.bashrc.aliases ~/

[ -f ~/.Xresources ] && mv ~/.Xresources ~/.dotfiles.old/
ln -s ~/Dotfiles/.Xresources ~/

[ -f ~/.vimrc ] && mv ~/.vimrc ~/.dotfiles.old/
ln -s ~/Dotfiles/.vimrc ~/

# Link Dotfiles's folders
# .vim .config

[ -d ~/.vim ] && [ ! -L ~/.vim ] && echo "Moving old \".vim\"" && mv ~/.vim ~/.dotfiles.old/
[ ! -L ~/.vim ] && ln -s ~/Dotfiles/.vim/ ~/.vim

# Config folder to link

# TODO: Get the folders name in .config to link and cycle trough them

[ ! -d ~/.dotfiles.old/.config ] && mkdir ~/.dotfiles.old/.config

# i3blocks
[ -d ~/.config/i3blocks ] && [ ! -L ~/.config/i3blocks ] && echo "Moving old \".config/i3/blocks\"" && mv ~/.config/i3blocks ~/.dotfiles.old/
[ ! -L ~/.config/i3blocks ] && ln -s ~/Dotfiles/.config/i3blocks/ ~/.config/i3blocks

# i3
[ -d ~/.config/i3 ] && [ ! -L ~/.config/i3 ] && echo "Moving old \".config/i3\"" && mv ~/.config/i3 ~/.dotfiles.old/.config
[ ! -L ~/.config/i3 ] && ln -s ~/Dotfiles/.config/i3/ ~/.config/i3

# ranger
[ -d ~/.config/ranger ] && [ ! -L ~/.config/ranger ] && echo "Moving old \".config/ranger\"" && mv ~/.config/ranger ~/.dotfiles.old/.config
[ ! -L ~/.config/ranger ] && ln -s ~/Dotfiles/.config/ranger/ ~/.config/ranger


[ -d ~/.scripts ] && [ ! -L ~/.scripts ] && echo "Moving old \".scripts\"" && mv ~/.scripts ~/.dotfiles.old/.config
[ ! -L ~/.scripts ] && ln -s ~/Dotfiles/.scripts/ ~/.scripts


# Wallpaper
# feh: set the wallpaper
# blurne: blurs the wallpaper
git clone https://github.com/ganifladi/blurme ~/.scripts/blurme
chmod +x ~/.scripts/blurme/blurme

# i3block-contrib
git clone https://github.com/vivien/i3blocks-contrib ~/.scripts/i3blocks-contrib
chmod +x ~/.scripts/i3blocks-contrib/shutdown_menu/shutdown_menu

# Vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

