#!/bin/bash

# Based on: https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh

chsh_zsh () {
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    sudo apt-get install zsh
    chsh_zsh
fi
}

chsh_zsh
