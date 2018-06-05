# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Vagrant image to use.
  config.vm.box = "gbarbieru/xenial"
  config.vm.network :private_network, ip: "192.168.99.99"
  
  # Shell script file for installations
  config.vm.provision :shell, :path => "install.sh"
  # Shell script for adding worpress site using existing template.
  # config.vm.provision :shell, :path => "install.sh"
  
  # For file sharing between host and guest.
  config.vm.synced_folder "./sharedFolder", "/var/www/html/"

# Customize the resources on the VM:
  config.vm.provider "virtualbox" do |vb|
  vb.memory = "2048"
  vb.cpus = "2"
 end

end