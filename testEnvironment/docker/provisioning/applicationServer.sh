#!/bin/bash

echo "Installing dependencies"
dnf install -y git

echo "Installing Docker"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable --now docker

echo "Cloning the repo"
cd /home/vagrant
if [ ! -d /home/vagrant/dotnet-2627-template ]; then
    git clone https://github.com/HOGENT-RISE/dotnet-2627-template.git /home/vagrant/dotnet-2627-template
fi

cd /home/vagrant/dotnet-2627-template

echo "Building Docker image"
docker build -t rise-server -f /vagrant/provisioning/Dockerfile .

echo "Starting Docker container"
docker run -d \
    --name rise-server \
    -p 5001:5001 \
    rise-server

echo "Application started on port 5001"
