# Ansible-Windows

A repo to test Ansible in a Windows environment.

## Installation

From the root directory of this repo, run: `vagrant up`

## Test Windows Connectivity

To confirm Windows connectivity, follow the steps below:

1. SSH into the Ansible Control VM:  
  `vagrant ssh ansible01`
1. Navigate to ansible directory:  
  `cd /vagrant/ansible/`
1. To use the `win_ping` module on `all` hosts in the `host` inventory file, run:  
  `ansible all -i hosts -m win_ping`
1. To collect useful information (Ansible Facts) on all hosts, use the `setup` module:  
  `ansible all -i hosts -m setup`
1. Facts for the Ansible Control node can be collected by running:  
  `ansible localhost -i hosts -m setup`

## Test Playbooks

Default values have been specified for the `Inventory` file and `Roles Path` in `ansible.cfg`:

```ini
[defaults]
inventory = hosts
roles_path = ${PWD}/roles
```

### Test a Simple Playbook

This playbook starts a service, enables telnet, and shows a different message depending on if the telnet feature was already installed or not.

1. Navigate to ansible directory:  
  `cd /vagrant/ansible/`
1. Run playbook:  
  `ansible-playbook testplaybook.yml`

### Test DSC and Delegation

This playbook uses `serial: 1` to apply configuration to one host at a time. `delegate_to: "{{ groups.webservers[0] }}"` is used so the resource is only executed on `groups.webservers[0]`, even when targetting other hosts.

1. Navigate to ansible directory:  
  `cd /vagrant/ansible/`
1. Run playbook, showing verbose messages (`-v`):  
  `ansible-playbook invokedsc.yml -v`

### Test a Role

This playbook uses a role called `common` to set the timezone and region / language settings.

1. Navigate to ansible directory:  
  `cd /vagrant/ansible/`
1. Run playbook:  
  `ansible-playbook use_role.yml`
  
### Test a Site-level Playbook

This playbook uses the `site.yml` playbook, which contains the `webservers.yml` playbook. Other playbooks could be used here if required.

The `webservers.yml` playbook contains the `common` role, and also installs the IIS Windows Feature. A conditional reboot task is included.

1. Navigate to ansible directory:  
  `cd /vagrant/ansible/`
1. Run playbook:  
  `ansible-playbook site.yml -v`

## Known Issues

There were issues with the latest versions of VirtualBox (5.2.22) / Vagrant (2.2.1) during initial testing, where
the NIC adapters were not recognised, so I ended up using older versions using [Chocolatey](https://chocolatey.org/docs/installation#installing-chocolatey):

```powershell
choco install virtualbox --version 5.2.18
choco install vagrant --version 2.1.5
```
