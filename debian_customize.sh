#!/bin/bash

~/dotfiles/chsh_zsh.sh
~/dotfiles/symlink_dotfiles.sh

rmdir Desktop Documents Downloads Music Pictures Public Templates Videos

echo "Compiling and installing dwm"
sudo apt-get install libx11-dev libxinerama-dev
cd /tmp
wget sovegjarto.com/dwm/dwm-6.0.tar.gz
tar xf dwm-6.0.tar.gz
cd dwm-6.0
make
sudo make install

echo "Installing core packages"
sudo apt-get update
sudo apt-get install $(cat ~/dotfiles/package_lists/core)

#echo "Installing pcb_dev packages"
#sudo apt-get install $(cat ~/dotfiles/package_lists/pcb_dev)
 
#echo "Installing latex packages"
#sudo apt-get install $(cat ~/dotfiles/package_lists/latex)
 
#echo "Installing avr-dev packages"
#sudo apt-get install $(cat ~/dotfiles/package_lists/avr-dev)
 
#echo "Installing msp430-dev packages"
#sudo apt-get install $(cat ~/dotfiles/package_lists/msp430-dev)
