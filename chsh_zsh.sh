#!/bin/bash

# Based on: https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh

chsh_zsh () {
if [ -f /bin/zsh ]; then
    if [[ ! $SHELL = "/bin/zsh" ]]; then
        chsh -s /bin/zsh
    fi
else
    sudo apt-get install zsh
    chsh_zsh
fi
}

chsh_zsh
