#!/bin/bash

# Install Ansible
echo "INFO: Started Installing Ansible..."
sudo yum -y install ansible
sudo pip install pywinrm
echo "INFO: Finished Installing Ansible."
