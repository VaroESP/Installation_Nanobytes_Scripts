#!/bin/bash
# Author: varoESP
# Description: Script to install Docker

GREEN='\033[38;5;46m'
NC='\033[0m'
echo
echo "#=== Starting the Docker installation ===#"
echo
echo "[] Remove previous versions..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
	sudo apt remove -y $pkg > /dev/null 2>&1
done
echo -ne "\033[A"
echo -ne "\033[K"
echo -e "[${GREEN}OK${NC}] Remove previous versions"
echo

echo "[] Update package list and dependencies"
sudo apt update > /dev/null 2>&1
sudo install -y ca-certificates curl > /dev/null 2>&1
echo -ne "\033[A"
echo -ne "\033[K"
echo -e "[${GREEN}OK${NC}] Update package list and dependencies"
echo

echo "[] Configure GPG directory"
sudo install -m 0755 -d /etc/apt/keyrings > /dev/null 2>&1
echo -ne "\033[A"
echo -ne "\033[K"
echo -e "[${GREEN}OK${NC}] Configure GPG directory"
echo

echo "[] Download official Docker GPG key"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc > /dev/null 2>&1
sudo chmod a+r /etc/apt/keyrings/docker.asc > /dev/null 2>&1
echo -ne "\033[A"
echo -ne "\033[K"
echo -e "[${GREEN}OK${NC}] Download official Docker GPG key"
echo

echo "[] Add official Docker repository"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo -ne "\033[A"
echo -ne "\033[K"
echo -e "[${GREEN}OK${NC}] Add official Docker repository"
echo

echo "[] Updating... again..."
sudo apt update > /dev/null 2>&1
echo -ne "\033[A"
echo -ne "\033[K"
echo -e "[${GREEN}OK${NC}] Update"
echo

echo "[] Install Docker components"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin > /dev/null 2>&1
echo -ne "\033[A"
echo -ne "\033[K"
echo -e "[${GREEN}OK${NC}] Install Docker components"
echo

echo "Checking Docker service status..."
sudo systemctl status docker --no-pager
echo

echo "#=== Installation completed ===#"
echo
echo "To use Docker without <sudo>, add your user to the docker group."
echo "	- sudo usermod -aG docker \$USER"
echo "Then log out and log back in."
echo

