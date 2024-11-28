![Frame 27](https://github.com/user-attachments/assets/c326eb30-8f2f-424a-a0c2-1d2988325cb7)
# 🛠️ Essential Dev Setup Script

This Bash script automates the installation of a complete development environment on a minimal Linux installation. It installs essential packages, language-specific tools, Docker, and a Zsh terminal customized with the Powerlevel10k theme and JetBrains Mono Nerd Font.


## 🖥️ Prerequisites

- An `apt`-based Linux distribution (Debian, Ubuntu, etc.).
- Root access or `sudo` privileges.


## 🚀 Features

- **Basic packages**: essential tools like `git`, `curl`, `wget`, `zsh`, `valgrind`, `clang`, etc.
- **Language support**: installs dependencies for Python, C/C++, and other common languages.
- **Docker**: installs Docker and Docker Compose.
- **Customized Zsh**:
  - Installs Zsh as the default terminal.
  - Configures the Powerlevel10k theme.
  - Adds the JetBrains Mono Nerd Font for a visually appealing terminal experience.


## 📦 Installation

1. Clone this repository and execute script:
   ```bash
   git clone https://github.com/monsieurCanard/SetupLinux.git
   cd setup-script && bash run_setup.sh
   ```
2. Reboot
   ```bash
   sudo reboot
   ```
⚠ You can use your own .zshrc and .p10k.zsh in user_file directory

## 🔧 Included Configurations

## IDE
- Vscode
- Vim
- Emacs

### Languages

- Python: `python3`, `pip3`
- C/C++: `gcc`, `g++`, `make`, `valgrind`
- PHP: `php`, `php-cli`
- JAVA: `default-jdk`, `default-jre`
- RUST: `rls`, `rust-analysis`, `rust-src`
- NODEJS: `nodejs`

### Docker

- Install Docker and configures user permissions to avoir needing `sudo` for Docker commands.

### Zsh and Powerlevel10k

- Zsh installation: sets Zsh as the default shell
- Powerlevel10k download: configured as default theme
- JetBrainMono Nerd Font: installed for optimal compatibility.

## 🤝 Contribution
Contributions are welcome! Feel free to open an issue or submit a pull request

