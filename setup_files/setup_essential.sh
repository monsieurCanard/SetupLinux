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
	 fzf valgrind clang \

sudo apt-get autoremove -y

echo "You use Visual Studio Code, NeoVim or Emacs ? (vscode/nvim/emacs)"
read -r response
if [[ "$response" =~ ^([vV][sS][cC][oO][dD][eE])$ ]]; then
	echo "Installing Visual Studio Code..."
	sudo wget -https://vscode.download.prss.microsoft.com/dbazure/download/stable/f1a4fb101478ce6ec82fe9627c43efbf9e98c813/code_1.95.3-1731513102_amd64.deb -O /tmp/vscode.deb
	sudo apt install ./tmp/vscode.deb
	rm -f /tmp/vscode.deb
elif [[ "$response" =~ ^([nN][vV][iI][mM])$ ]]; then
	echo "Installing NeoVim..."
	sudo apt install -y neovim
elif [[ "$response" =~ ^([eE][mM][aA][cC][sS])$ ]]; then
	echo "Installing Emacs..."
	sudo apt-get install -y emacs
else
	echo "No editor installed."
fi