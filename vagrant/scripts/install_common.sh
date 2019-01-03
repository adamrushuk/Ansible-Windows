#!/bin/bash

# Install common utils
echo "INFO: Started Installing Extra Packages Repo and useful utils..."
yum -y install epel-release tree git vim bash-completion python-pip
pip install --upgrade pip
yum -y update
echo "INFO: Finished Installing Extra Packages Repo and useful utils."
