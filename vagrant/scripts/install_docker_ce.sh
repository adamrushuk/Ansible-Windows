#!/bin/bash

# Installs Docker CE
echo "INFO: Started Installing Docker..."

# Remove older versions
sudo yum -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine

# Set up repo
sudo yum -y install yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker
sudo yum -y install docker-ce docker-python
sudo pip install docker-compose==1.9.0

# Start Docker and enable auto-start on boot
sudo systemctl start docker
sudo systemctl enable docker

# Check Docker status
sudo systemctl status docker

# Check Docker version (was "Docker version 18.09.0, build 4d60db4" during testing)
docker -v

echo "INFO: Finished Installing Docker."
