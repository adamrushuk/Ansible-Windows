#!/bin/bash

# Installs Ansible AWX
echo "INFO: Started Installing Ansible AWX..."

# Clone repo
ansible_git_folder="/root/awx/"
if [ ! -d "$ansible_git_folder" ]
then
    echo "INFO: Cloning Ansible AWX repo..."
    cd /root/
    git clone https://github.com/ansible/awx.git
else
    echo "INFO: Ansible AWX repo already exists...SKIPPING."
fi

# Copy (overwrite) inventory file from vagrant share
echo "INFO: Copying Ansible AWX Inventory file..."
\cp /vagrant/vagrant/scripts/inventory /root/awx/installer/inventory

# Run installer Playbook
echo "INFO: Running Ansible AWX install playbook..."
cd /root/awx/installer/
ansible-playbook -i inventory install.yml

# Confirm build with
# docker ps
# docker logs -f awx_task

echo "INFO: Finished Installing Ansible AWX."
