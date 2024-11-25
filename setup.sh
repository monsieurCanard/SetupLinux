#!/bin/bash

echo "Install setup for Monsieur Canard !"
echo "You need to have an internet connection and sudo rights."

# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Unsupported distribution"
    exit 1
fi

# Function to install packages for Debian/Ubuntu
install_debian() {
	echo "Debian/Ubuntu detected ! Installing packages..."
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt-get install -y build-essential git curl valgrind wget python3 python3-pip g++ make gcc clang-15
    sudo apt-get install -y software-properties-common apt-transport-https snapd
    sudo systemctl enable --now snapd.socket
    sudo ln -s /var/lib/snapd/snap /snap
    sudo snap install code --classic
    sudo apt update
    sudo apt install -y firefox
	#  docker.io docker-compose
    # sudo systemctl start docker
    # sudo systemctl enable docker
    # sudo usermod -aG docker $USER
}

# # Function to install packages for Fedora
# install_fedora() {
# 	echo "Fedora detected ! Installing packages..."
#     sudo dnf update -y
#     sudo dnf install -y @development-tools git curl valgrind wget python3 python3-pip gcc-c++ make clang
#     sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
#     sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
#     sudo dnf check-update
#     sudo dnf install -y code firefox docker docker-compose
#     sudo systemctl start docker
#     sudo systemctl enable docker
#     sudo usermod -aG docker $USER
# }

# Install packages based on the detected distribution
case $OS in
    ubuntu|debian)
        install_debian
        ;;
    fedora)
        install_fedora
        ;;
    *)
        echo "Unsupported distribution: $OS ! Sorry :("
        exit 1
        ;;
esac

#  * ! Install Vscode

# echo "Installing VSCode..."
# sudo apt install -y software-properties-common apt-transport-https
# wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
# sudo apt update
# sudo apt install -y code


#  * ! Install Mozilla Firefox

echo "Installing Mozilla Firefox..."
sudo apt install -y firefox

# #  * ! Install Docker

# echo "Installing Docker..."
# sudo apt install -y docker.io
# sudo systemctl start docker
# sudo systemctl enable docker
# sudo usermod -aG docker $USER


# #  * ! Install Docker Compose

# echo "Installing Docker Compose..."
# sudo apt install -y docker-compose

sudo apt install -y zsh

#  * ! Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Install Oh My Zsh..."
	RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	chsh -s $(which zsh)
else 
	echo "Oh My Zsh already installed."
fi

cat .zshrc >> "$HOME/.zshrc"
#  * ! Install Zsh plugins

echo "Install Zsh plugins..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
	git clone https://github.com/zsh-users/zsh-completions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
fi


#  * ! Install Powerlevel10k
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
	echo "Installation de Powerlevel10k..."
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
	sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
	echo "Configuration de Powerlevel10k..."
else
	echo "Powerlevel10k est déjà installé."
fi
cat .p10k.zsh >> "$HOME/.p10k.zsh"

if ! grep -q "source $HOME/.p10k.zsh" "$HOME/.zshrc"; then
	echo "source $HOME/.p10k.zsh" >> "$HOME/.zshrc"
fi

# Clean up unnecessary packages
sudo apt-get autoremove -y