#!/bin/bash

echo "Install essential setup for Monsieur Canard !"
echo "You need to have an internet connection and sudo rights."

sudo dpkg --configure -a

sudo apt-get install -f -y

sudo apt-get clean

sudo apt-get update

sudo apt-get upgrade -y

sudo apt-get check

sudo apt install -y \
	 build-essential git curl \
	 wget zsh fonts-powerline \
	 fzf valgrind clang snapd\

sudo apt-get autoremove -y

echo "You use Visual Studio Code, NeoVim or Emacs ? (vscode/nvim/emacs)"
read -r response
if [[ "$response" =~ ^([vV][sS][cC][oO][dD][eE])$ ]]; then
	echo "Installing Visual Studio Code..."
	sudo snap install --classic code
elif [[ "$response" =~ ^([nN][vV][iI][mM])$ ]]; then
	echo "Installing NeoVim..."
	sudo apt install -y neovim
elif [[ "$response" =~ ^([eE][mM][aA][cC][sS])$ ]]; then
	echo "Installing Emacs..."
	sudo apt-get install -y emacs
else
	echo "No editor installed."
fi