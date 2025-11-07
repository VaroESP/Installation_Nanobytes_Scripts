#!/bin/bash
# Author: varoESP
# Description: Script to install Docker in Linux Ubuntu

echo "#=== Starting the Docker installation ===#"

echo "Removing previous versions"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
	sudo apt remove -y $pkg > 2/dev/null 2>&1
done
echo "[OK] Removing previous versions"
echo

echo "Updating package list and dependencies"
sudo apt update > 2/dev/null 2>&1
sudo install -y ca-certificates curl > 2/dev/null 2>&1
echo "[OK] Updating package list and dependencies"
echo

echo "Installing dependencies"
sudo install -m 0755 -d /etc/apt/keyrings > 2/dev/null 2>&1
echo "[OK] Installing dependencies"
echo

echo "Downloading official Docker GPG key"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc > 2/dev/null 2>&1
sudo chmod a+r /etc/apt/keyrings/docker.asc > 2/dev/null 2>&1
echo "[OK] Downloading official Docker GPG key"
echo

echo "Agregando repositorio oficial de Docker"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "[OK] Agregando repositorio oficial de Docker"
echo

echo "Updating... again..."
sudo apt update > 2/dev/null 2>&1
echo "[OK] Updating... again..."
echo

echo "Installing Docker components"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin > 2/dev/null 2>&1
echo "[OK] Installing Docker components"
echo

echo "Checking Docker service status..."
sudo systemctl status docker --no-pager
echo

echo "Commands for manual startup:"
echo "	- sudo systemctl start docker"
echo "	- sudo systemcrl enable docker"
echo

echo "#=== Installation completed ===#"
echo "To use Docker without <sudo>, add your user to the docker group."
echo "	- sudo usermod -aG docker \$USER"
echo "Then log out and log back in."

