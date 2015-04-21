#
# Cookbook Name:: virt-kvm
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# install virsh base package
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
  gid 9001
  members node["virt-kvm"]["kvm-member"]
  append true
end

# これはbaseとかに分けて最初の一回だけ実行するようにした方いいかも
file "/etc/libvirt/libvirtd.conf.org" do
  content IO.read("/etc/libvirt/libvirtd.conf")
end

template 'libvirtd.conf.erb' do
  path '/etc/libvirt/libvirtd.conf'
  source "libvirtd.conf.erb"
  owner   'root'
  group   'root'
  mode    '0644'
  notifies :reload, "service[libvirtd]"
end

service "libvirtd" do
  action [:enable, :start]
end

include_recipe 'sysctl'
sysctl_param 'net.ipv4.ip_forward' do
  value 1
end

# sysctl recipeだと運用中sysctl -pとかされると値が戻るのでしかたなく

file "/etc/sysctl.conf" do
  _file = Chef::Util::FileEdit.new(path)
  _file.search_file_replace_line("net.ipv4.ip_forward = 0", "net.ipv4.ip_forward = 1\n")
  content _file.send(:editor).lines.join
end
