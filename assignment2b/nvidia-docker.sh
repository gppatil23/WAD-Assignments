#!/bin/bash

# Script to set up NVIDIA Docker on Ubuntu
# This script installs Docker and NVIDIA Container Toolkit

# Exit on any error
set -e

# Update package list
echo "Updating package list..."
apt-get update

# Install prerequisites
echo "Installing prerequisites..."
apt-get install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# Add Docker repository
echo "Adding Docker repository..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
echo "Installing Docker..."
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Add current user to docker group (to run docker without sudo)
echo "Adding user to docker group..."
usermod -aG docker $USER

# Setup NVIDIA Docker repository
echo "Setting up NVIDIA Docker repository..."
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list

# Install NVIDIA Container Toolkit
echo "Installing NVIDIA Container Toolkit..."
apt-get update
apt-get install -y nvidia-docker2

# Restart Docker daemon
echo "Restarting Docker daemon..."
systemctl restart docker

# Verify installation
echo "Verifying NVIDIA Docker installation..."
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi

echo "NVIDIA Docker setup complete!"
echo "You may need to log out and log back in for group changes to take effect."