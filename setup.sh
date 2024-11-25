#!/bin/bash

echo "Install setup for Monsieur Canard !"
echo "You need to have an internet connection and sudo rights."

# Corriger les problèmes de dpkg interrompu
sudo dpkg --configure -a

# Corriger les dépendances cassées
sudo apt-get install -f -y

# Nettoyer le cache d'APT
sudo apt-get clean

# Mettre à jour la liste des paquets
sudo apt-get update

# Vérifier les paquets cassés
sudo apt-get check

# Installer Zsh
echo "Installing Zsh..."
sudo apt install -y zsh

# Installer Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s $(which zsh) $USER
else 
    echo "Oh My Zsh already installed."
fi

# Copier le fichier .zshrc
if [ -f .zshrc ]; then
    echo "Copying .zshrc..."
    cat .zshrc >> "$HOME/.zshrc"
else
    echo ".zshrc file not found!"
fi

# Installer les plugins Zsh
echo "Installing Zsh plugins..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
fi

# Installer Powerlevel10k
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
    echo "Configuring Powerlevel10k..."
else
    echo "Powerlevel10k is already installed."
fi

# Copier le fichier .p10k.zsh
if [ -f .p10k.zsh ]; then
    echo "Copying .p10k.zsh..."
    cat .p10k.zsh >> "$HOME/.p10k.zsh"
else
    echo ".p10k.zsh file not found!"
fi

# Ajouter la source de .p10k.zsh dans .zshrc
if ! grep -q "source $HOME/.p10k.zsh" "$HOME/.zshrc"; then
    echo "Adding source for .p10k.zsh to .zshrc..."
    echo "source $HOME/.p10k.zsh" >> "$HOME/.zshrc"
fi

# Nettoyer les paquets inutiles
sudo apt-get autoremove -y

echo "Script execution completed successfully."

# Redémarrer le shell pour appliquer les changements
exec zsh