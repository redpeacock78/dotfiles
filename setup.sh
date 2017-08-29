#!/bin/sh

 set -e
 set -u

 setup() {
     dotfiles=$HOME/.dotfiles

     has() {
         type "$1" > /dev/null 2>&1
     }

     symlink() {
         [ -e "$2" ] || ln -s "$1" "$2"
     }

     if [ -d "$dotfiles" ]; then
         (cd "$dotfiles" && git pull --rebase)
     else
         git clone https://github.com/redpeacock78/.dotfiles "$dotfiles"
     fi

     has git && symlink "$dotfiles/bin/" "$HOME/bin"
     has git && symlink "$dotfiles/.zshrc" "$HOME/.zshrc"
     has vim && symlink "$dotfiles/.zsh/" "$HOME/.zsh/"
 }

 setup
