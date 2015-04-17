#
# Cookbook Name:: virt-kvm
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{bridge-utils libvirt libvirt qemu-kvm virt-top qemu-kvm-tools virt-viewer}.each do |pkg|
  package pkg do
    action :install
  end
end

# install virt-edit
%w{libguestfs libguestfs-tools libguestfs-tools-c}.each do |pkg|
  package pkg do
    action :install
  end
end

group 'libvirt' do
  members node["virt-kvm"]["kvm-member"]
  append true
end
