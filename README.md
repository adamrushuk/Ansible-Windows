# Ansible-Windows

A repo to test Ansible in a Windows environment.

## Installation

From the root directory of this repo, run: `vagrant up`

## Testing

To confirm Windows connectivity, follow the steps below:

1. SSH into the Ansible Control VM:  
  `vagrant ssh ansible01`
1. Navigate to ansible directory:  
  `cd /vagrant/ansible/`
1. To use the `win_ping` module on `all` hosts in the `host` inventory file, run:  
  `ansible all -i hosts -m win_ping`
1. To collect useful information (Ansible Facts) on all hosts, use the `setup` module:  
  `ansible all -i hosts -m setup`

## Known Issues

There were issues with the latest versions of VirtualBox (5.2.22) / Vagrant (2.2.1) during initial testing, where
the NIC adapters were not recognised, so I ended up using older versions using [Chocolatey](https://chocolatey.org/docs/installation#installing-chocolatey):

```powershell
choco install virtualbox --version 5.2.18
choco install vagrant --version 2.1.5
```
