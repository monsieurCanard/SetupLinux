#!/bin/bash

echo "Install terminal setup for Monsieur Canard !"

# ! INSTALLATION OF NERD FONTS

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

wget  https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip -O /tmp/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR"
rm -f /tmp/JetBrainsMono.zip

fc-cache -fv

# ! CHANGE DEFAULT TERMINAL FONT
PROFILE=$(dconf list /org/gnome/terminal/legacy/profiles:/ | grep '^:' | head -n1)
PROFILE=${PROFILE%/}
dconf write /org/gnome/terminal/legacy/profiles:/$PROFILE/font "'JetBrainsMono Nerd Font Mono 12'"
dconf write /org/gnome/terminal/legacy/profiles:/$PROFILE/use-system-font false


# ! INSTALLATION OF OH MY ZSH
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s $(which zsh) $USER
else 
    echo "Oh My Zsh already installed."
fi

cat ./user_files/.zshrc > "$HOME/.zshrc"

# ! INSTALLATION OF ZSH PLUGINS

echo "Installing Zsh plugins..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
fi

# ! INSTALLATION OF POWERLEVEL10K

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
else
    echo "Powerlevel10k is already installed."
fi


cp ./user_files/.p10k.zsh "$HOME/.p10k.zsh"

if ! grep -q "source $HOME/.p10k.zsh" "$HOME/.zshrc"; then
    echo "Adding source for .p10k.zsh to .zshrc..."
    echo "source $HOME/.p10k.zsh" >> "$HOME/.zshrc"
fi

# ! END OF INSTALLATION

sudo apt-get autoremove -y

source ~/.zshrc

exec zsh
