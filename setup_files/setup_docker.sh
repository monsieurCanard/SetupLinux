#!/bin/bash

echo "Do you want to install Docker and Docker Compose ? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	echo "Installing Docker and Docker Compose for Monsieur Canard !"
	sudo apt-get install -y docker.io docker-compose
	sudo usermod -aG docker "$USER"
fi

# ! END OF INSTALLATION