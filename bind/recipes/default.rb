#
# Cookbook Name:: bind
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{bind bind-utils}.each do |pkg|
  package pkg do
   action :install
  end
end

service "named" do
  action [:enable, :start]
  supports :status => true, :restart => true, :reload => true
end

template 'named.conf' do
  path '/etc/named.conf'
  source "named.conf.erb"
  owner   'named'
  group   'named'
  mode    '0644'
  notifies  :reload, "service[named]"
end

directory "/var/log/named" do
  owner   'named'
  group   'named'
  mode    0755
  action  :create
end
