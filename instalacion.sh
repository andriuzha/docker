#!/bin/bash
# Actualiza Debian
apt update && sudo apt upgrade -y

# Remueve las instalaciones anteriores de Docker
apt remove docker-ce docker-ce-cli containerd.io -y
apt remove docker docker-engine docker.io containerd runc -y

# Actualiza el índice de paquetes apt e instala paquetes para permitir repositorios a través de HTTPS:
apt update
apt install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

# Añade la clave GPG oficial de Docker
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Configura el repositorio:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instala Docker Engine
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Reinicia el servidor
shutdown -r 0
