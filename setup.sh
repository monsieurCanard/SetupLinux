#!/bin/bash

echo "Install setup for Monsieur Canard !"
echo "You need to have an internet connection and sudo rights."

sudo dpkg --configure -a

sudo apt-get install -f -y

sudo apt-get clean

sudo apt-get update

sudo apt-get check

sudo apt install -y git curl wget zsh fonts-powerline 

echo "Installing Zsh..."
sudo apt install -y zsh

echo "Installing fonts for Powerlevel10k..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Télécharger toutes les variantes de la police
wget -qO "$FONT_DIR/MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -qO "$FONT_DIR/MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -qO "$FONT_DIR/MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -qO "$FONT_DIR/MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Mettre à jour le cache des polices
fc-cache -fv


if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s $(which zsh) $USER
else 
    echo "Oh My Zsh already installed."
fi

if [ -f .zshrc ]; then
    echo "Copying .zshrc..."
    cat .zshrc > "$HOME/.zshrc"
else
    echo ".zshrc file not found!"
fi

echo "Installing Zsh plugins..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    # echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    echo "Configuring Powerlevel10k..."
else
    echo "Powerlevel10k is already installed."
fi

# Copier le fichier .p10k.zsh
if [ -f .p10k.zsh ]; then
    echo "Copying .p10k.zsh..."
    cat .p10k.zsh > "$HOME/.p10k.zsh"
else
    echo ".p10k.zsh file not found!"
fi

sudo apt-get autoremove -y

echo "Script execution completed successfully."

sudo reboot

