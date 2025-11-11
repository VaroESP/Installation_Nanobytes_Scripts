#!/bin/bash
# Author: varoESP
# Description: Script to install Docker in Linux Ubuntu

GREEN='\033[38;5;46m'
NC='\033[0m'

echo "#=== Starting the Docker installation ===#"

echo "[] Remove previous versions..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
	sudo apt remove -y $pkg > /dev/null 2>&1
done
echo -ne "\033[A"
echo -ne "\033[K"
echo "[${GREEN}OK${NC}] Remove previous versions"

echo "[] Update package list and dependencies"
sudo apt update > /dev/null 2>&1
sudo install -y ca-certificates curl > /dev/null 2>&1
echo -ne "\033[A"
echo -ne "\033[K"
echo "[${GREEN}OK${NC}] Update package list and dependencies"

echo "[] Configure GPG directory"
sudo install -m 0755 -d /etc/apt/keyrings > /dev/null 2>&1
echo -ne "\033[A"
echo -ne "\033[K"
echo "[${GREEN}OK${NC}] Configure GPG directory"

echo "[] Download official Docker GPG key"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc > /dev/null 2>&1
sudo chmod a+r /etc/apt/keyrings/docker.asc > /dev/null 2>&1
echo -ne "\033[A"
echo -ne "\033[K"
echo "[${GREEN}OK${NC}] Download official Docker GPG key"

echo "Agregando repositorio oficial de Docker"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo -ne "\033[A"
echo -ne "\033[K"
echo "[${GREEN}OK${NC}] Agregando repositorio oficial de Docker"

echo "Updating... again..."
sudo apt update > /dev/null 2>&1
echo -ne "\033[A"
echo -ne "\033[K"
echo "[${GREEN}OK${NC}] Updating... again..."

echo "Installing Docker components"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin > /dev/null 2>&1
echo -ne "\033[A"
echo -ne "\033[K"
echo "[${GREEN}OK${NC}] Installing Docker components"
echo

echo "Checking Docker service status..."
sudo systemctl status docker --no-pager

echo "Commands for manual startup:"
echo "	- sudo systemctl start docker"
echo "	- sudo systemcrl enable docker"
echo

echo "#=== Installation completed ===#"
echo "To use Docker without <sudo>, add your user to the docker group."
echo "	- sudo usermod -aG docker \$USER"
echo "Then log out and log back in."

