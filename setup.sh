#!/bin/bash

echo "Install setup for Monsieur Canard !"
echo "You need to have an internet connection and sudo rights."

sudo dpkg --configure -a

sudo apt-get install -f -y

sudo apt-get clean

sudo apt-get update

sudo apt-get check

sudo apt install -y curl wget zsh fonts-powerline 

echo "Installing Zsh..."
sudo apt install -y zsh

echo "Installing fonts for Powerlevel10k..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

wget  https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip -O /tmp/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR"
rm -f /tmp/JetBrainsMono.zip

# Mettre à jour le cache des polices
fc-cache -fv

PROFILE=$(dconf list /org/gnome/terminal/legacy/profiles:/ | grep '^:' | head -n1)
PROFILE=${PROFILE%/}
dconf write /org/gnome/terminal/legacy/profiles:/$PROFILE/font "'JetBrainsMono Nerd Font Mono 12'"
dconf write /org/gnome/terminal/legacy/profiles:/$PROFILE/use-system-font false


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
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
else
    echo "Powerlevel10k is already installed."
fi

# Copier le fichier .p10k.zsh
if [ -f .p10k.zsh ]; then
    echo "Copying .p10k.zsh..."
    cp .p10k.zsh "$HOME/.p10k.zsh"
else
    echo ".p10k.zsh file not found!"
fi

# Ajouter la source de .p10k.zsh dans .zshrc
if ! grep -q "source $HOME/.p10k.zsh" "$HOME/.zshrc"; then
    echo "Adding source for .p10k.zsh to .zshrc..."
    echo "source $HOME/.p10k.zsh" >> "$HOME/.zshrc"
fi

sudo apt-get autoremove -y

echo "Script execution completed successfully."

source ~/.zshrc

exec zsh
