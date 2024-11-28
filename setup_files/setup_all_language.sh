#!/bin/bash

# ! INSTALLATION OF C LANGUAGE
echo "Do you use C language ? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	echo "Installing C language setup for Monsieur Canard !"
	sudo apt-get install -y gcc gdb
else
	echo "C language setup not installed."
fi

# ! INSTALLATION OF C++ LANGUAGE
echo "Do you use C++ language ? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	sudo apt-get install -y g++ gdb 
else
	echo "C++ language setup not installed."
fi

# ! INSTALLATION OF PYTHON LANGUAGE
echo "Do you use Python language ? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	echo "Installing Python language setup for Monsieur Canard !"
	sudo apt-get install -y python3 python3-pip
	pip3 install --upgrade pip
	pip3 install virtualenv
else
	echo "Python language setup not installed."
fi

# ! INSTALLATION OF PHP LANGUAGE
echo "Do you use PHP language ? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	echo "Installing PHP language setup for Monsieur Canard !"
	sudo apt-get install -y php php-cli
else
	echo "PHP language setup not installed."
fi

