#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'java-1.7.0-openjdk' do
  action :install
end

remote_file '/tmp/' + node['jenkins']['rpm'] do
  source node['jenkins']['rpm_url']
  owner "root"
  group "root"
  mode "0755"
  not_if "test -e " + '/tmp/' + node['jenkins']['rpm']
end

package "jenkins" do
  action :install
  source '/tmp/' + node['jenkins']['rpm']
  provider Chef::Provider::Package::Rpm
  not_if "rpm -q jenkins"
end

service "jenkins" do
  action [:enable, :start]
end
