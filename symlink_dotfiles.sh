#!/bin/bash

dotfiles="
xsession
Xdefaults
vimrc
zshrc
dir_colors
gitconfig
"

for dotfile in $dotfiles; do

    # Backup dotfile if it already exists
    [ -f ~/.$dotfile ] && mkdir -p ~/dotfiles_old && mv ~/.$dotfile ~/dotfiles_old

    # Symlink new dotfile
    ln -s dotfiles/$dotfile ~/.$dotfile
    echo .$dotfile symlinked
done

mkdir ~/.pcb
ln -s dotfiles/pcb_settings ~/.pcb/settings
