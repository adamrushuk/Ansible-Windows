# Plugin checker by DevNIX: https://github.com/DevNIX/Vagrant-dependency-manager
# vagrant-reload is required to reboot Windows machines and retain Vagrant connection
require File.dirname(__FILE__)+'./Vagrant/Plugin/dependency_manager'
check_plugins ['vagrant-reload']

# Variables
## Boxes
windows_box_name    = 'adamrushuk/win2016-std-dev'
windows_box_version = '1809.1.0'
linux_box_name      = 'bento/centos-7.6'
linux_box_version   = '201812.27.0'

## Network
## NIC Adapter #2 (1st NIC is reserved for Vagrant comms)
net_prefix          = '192.168.10'
ansible01_ip        = "#{net_prefix}.10"
web01_ip            = "#{net_prefix}.11"
web02_ip            = "#{net_prefix}.12"


# Main configuration
Vagrant.configure('2') do |config|

  # VirtualBox global box settings
  config.vm.provider 'virtualbox' do |vb|
    vb.linked_clone = true
    vb.gui          = true
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['setextradata', 'global', 'GUI/SuppressMessages', 'all']
    # vb.default_nic_type = '82545EM' # not required as now using older version of VBox / Vagrant
  end

  # Increase timeout in case VMs joining the domain take a while to boot
  config.vm.boot_timeout = 1200


  # Ansible Control VM
  config.vm.define 'ansible01' do |subconfig|
      # CPU and RAM
      subconfig.vm.provider 'virtualbox' do |vb|
        vb.cpus   = '1'
        vb.memory = '2048'
      end

      # Hostname and networking
      subconfig.vm.hostname    = 'ansible01'
      subconfig.vm.box         = linux_box_name
      subconfig.vm.box_version = linux_box_version
      subconfig.vm.network 'private_network', ip: ansible01_ip
      subconfig.vm.network 'forwarded_port', guest: 22, host: 33510, auto_correct: true
      subconfig.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__auto: true

      # Provisioning
      subconfig.vm.provision 'shell', path: 'vagrant/scripts/install_common.sh'
      # Install Ansible
      subconfig.vm.provision 'shell', path: 'vagrant/scripts/install_ansible.sh'
      # Install Docker
      subconfig.vm.provision 'shell', path: 'vagrant/scripts/install_docker_ce.sh'
      # Install Ansible AWX
      subconfig.vm.provision 'shell', path: 'vagrant/scripts/install_ansible_awx.sh'
    end


  # Web01
  config.vm.define 'web01' do |subconfig|
    # CPU and RAM
    subconfig.vm.provider 'virtualbox' do |vb|
      vb.cpus = '2'
      vb.memory = '2048'
    end

    # WinRM plaintext is required for the domain to build properly (These settings should NOT be used on production machines)
    subconfig.vm.communicator       = 'winrm'
    subconfig.winrm.transport       = :plaintext
    subconfig.winrm.basic_auth_only = true

    # Hostname and networking
    subconfig.vm.hostname    = 'web01'
    subconfig.vm.box         = windows_box_name
    subconfig.vm.box_version = windows_box_version
    subconfig.vm.network 'private_network', ip: web01_ip
    subconfig.vm.network 'forwarded_port', guest: 3389, host: 33511, auto_correct: true
    subconfig.vm.network 'forwarded_port', guest: 80, host: 33512, auto_correct: true
    subconfig.vm.network 'forwarded_port', guest: 443, host: 33513, auto_correct: true

    # Provisioning
    # Reset Windows license
    subconfig.vm.provision 'shell', inline: 'cscript slmgr.vbs /rearm //B //NOLOGO'
    # Configure remoting for Ansible
    subconfig.vm.provision 'shell', path: 'vagrant/scripts/ConfigureRemotingForAnsible.ps1'
    # Reboot VM
    subconfig.vm.provision :reload
  end


  # Web02
  config.vm.define 'web02' do |subconfig|
    # CPU and RAM
    subconfig.vm.provider 'virtualbox' do |vb|
      vb.cpus = '2'
      vb.memory = '2048'
    end

    # WinRM plaintext is required for the domain to build properly (These settings should NOT be used on production machines)
    subconfig.vm.communicator       = 'winrm'
    subconfig.winrm.transport       = :plaintext
    subconfig.winrm.basic_auth_only = true

    # Hostname and networking
    subconfig.vm.hostname    = 'web02'
    subconfig.vm.box         = windows_box_name
    subconfig.vm.box_version = windows_box_version
    subconfig.vm.network 'private_network', ip: web02_ip
    subconfig.vm.network 'forwarded_port', guest: 3389, host: 33514, auto_correct: true
    subconfig.vm.network 'forwarded_port', guest: 80, host: 33515, auto_correct: true
    subconfig.vm.network 'forwarded_port', guest: 443, host: 33516, auto_correct: true

    # Provisioning
    # Reset Windows license
    subconfig.vm.provision 'shell', inline: 'cscript slmgr.vbs /rearm //B //NOLOGO'
    # Configure remoting for Ansible
    subconfig.vm.provision 'shell', path: 'vagrant/scripts/ConfigureRemotingForAnsible.ps1'
    # Reboot VM
    subconfig.vm.provision :reload
  end

end
