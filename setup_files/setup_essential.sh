#!/bin/bash

echo "Install essential setup for Monsieur Canard !"
echo "You need to have an internet connection and sudo rights."

sudo dpkg --configure -a

sudo apt-get install -f -y

sudo apt-get clean

sudo apt-get update

sudo apt-get check

sudo apt install -y git curl wget zsh fonts-powerline fzf valgrind clang snapd 

echo "You use Visual Studio Code, Vim or Emacs ? (vscode/vim/emacs)"
read -r response
if [[ "$response" =~ ^([vV][sS][cC][oO][dD][eE])$ ]]; then
	echo "Installing Visual Studio Code..."
	sudo snap install --classic code
elif [[ "$response" =~ ^([vV][iI][mM])$ ]]; then
	echo "Installing Vim..."
	sudo apt-get install -y vim
elif [[ "$response" =~ ^([eE][mM][aA][cC][sS])$ ]]; then
	echo "Installing Emacs..."
	sudo apt-get install -y emacs
fi