# Variables
## Boxes
windows_box_name    = 'adamrushuk/win2016-std-dev'
windows_box_version = '1809.1.0'
linux_box_name      = 'centos/7'
linux_box_version   = '1809.01'

## Network
## NIC Adapter #2 (1st NIC is reserved for Vagrant comms)
net_prefix          = '192.168.56'
ansible01_ip        = "#{net_prefix}.10"
web01_ip            = "#{net_prefix}.11"


# Main configuration
Vagrant.configure('2') do |config|

    # VirtualBox global box settings
    config.vm.provider 'virtualbox' do |vb|
      vb.linked_clone = true
      vb.gui          = true
      vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
      vb.customize ['setextradata', 'global', 'GUI/SuppressMessages', 'all']
    end

    # Increase timeout in case VMs joining the domain take a while to boot
    config.vm.boot_timeout = 600


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
        subconfig.vm.network 'forwarded_port', guest: 22, host: 33510, auto_correct: false

        # Provisioning
        # Install Ansible
        subconfig.vm.provision 'shell', inline: <<-SHELL
          yum -y install epel-release
          yum -y install ansible
          yum -y install python-pip
          pip install --upgrade pip
          pip install pywinrm
        SHELL
      end


    # Web01
    config.vm.define 'web01' do |subconfig|
      # CPU and RAM
      subconfig.vm.provider 'virtualbox' do |vb|
        vb.cpus = '1'
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
      subconfig.vm.network 'forwarded_port', guest: 3389, host: 33511, auto_correct: false
      subconfig.vm.network 'forwarded_port', guest: 80, host: 33512, auto_correct: false
      subconfig.vm.network 'forwarded_port', guest: 443, host: 33513, auto_correct: false
    end
  end
