#!/bin/bash

# Install common utils
echo "INFO: Started Installing Extra Packages Repo and useful utils..."
yum -y install epel-release --enablerepo=extras
yum -y update
yum -y install tree git vim bash-completion
yum -y install python-pip
pip install pip --upgrade
echo "INFO: Finished Installing Extra Packages Repo and useful utils."
