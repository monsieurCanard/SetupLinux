#!/bin/bash

echo "Install essential setup for Monsieur Canard !"
echo "You need to have an internet connection and sudo rights."

sudo dpkg --configure -a

sudo apt-get install -f -y

sudo apt-get clean

sudo apt-get update

sudo apt-get check

sudo apt install -y curl wget zsh fonts-powerline fzf valgrind clang snapd

sudo snap install --classic code