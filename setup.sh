#!/bin/bash

echo "Install setup for Monsieur Canard !"
echo "You need to have an internet connection and sudo rights."
echo "Press Enter to continue..."
# read -n 1 -s

# if [ $? -eq 0]; then
# 	echo "Let's go !"
# else
# 	echo "Exiting..."
# 	exit 1
# fi

echo "Update and upgrade packages..."
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y build-essential
sudo apt-get install -y git curl wget python3 python3-pip g++ make gcc

echo "Installing VSCode..."
sudo apt install -y software-properties-common apt-transport-https
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install -y code

echo "Installing Mozilla Firefox..."
sudo apt install -y firefox

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Install Oh My Zsh..."
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	chsh -s $(which zsh)
else 
	echo "Oh My Zsh already installed."
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
	echo "Installation de Powerlevel10k..."
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
	sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
	echo "Configuration de Powerlevel10k..."
	cat << 'EOF' >> ~/.p10k.zsh
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
EOF
else
	echo "Powerlevel10k est déjà installé."
fi

if [ ! grep -q "source $HOME/.p10k.zsh" "$HOME/.zshrc" ]; then
	echo "source $HOME/.p10k.zsh" >> "$HOME/.zshrc"
fi