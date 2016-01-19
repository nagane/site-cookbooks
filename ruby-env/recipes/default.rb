#
# Cookbook Name:: ruby-env
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{git openssl-devel sqlite-devel gcc readline-devel libffi-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

git "/home/#{node['ruby-env']['user']}/.rbenv" do
  repository node["ruby-env"]["rbenv_url"]
  action :sync
  user node['ruby-env']['user']
  group node['ruby-env']['user']
end

template ".bash_profile" do
  source ".bash_profile.erb"
  path   "/home/#{node['ruby-env']['user']}/.bash_profile"
  mode   0644
  owner  node['ruby-env']['user']
  group  node['ruby-env']['group']
  not_if "grep rbenv ~/.bash_profile", :environment => { :'HOME' => "/home/#{node['ruby-env']['user']}" }
end

directory "/home/#{node['ruby-env']['user']}/.rbenv/plugins" do
  owner   node['ruby-env']['user']
  group   node['ruby-env']['group']
  mode    0755
  action  :create
end

git "/home/#{node['ruby-env']['user']}/.rbenv/plugins/ruby-build" do
  repository node["ruby-env"]["ruby-build_url"]
  action :sync
  user      node['ruby-env']['user']
  group     node['ruby-env']['group']
end

execute "rbenv install #{node['ruby-env']['version']}" do
  command "/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv install #{node['ruby-env']['version']}"
  user    node['ruby-env']['user']
  group   node['ruby-env']['group']
  environment 'HOME' => "/home/#{node['ruby-env']['user']}"
  not_if  { File.exists?("/home/#{node['ruby-env']['user']}/.rbenv/versions/#{node['ruby-env']['version']}")}
end

bash "ruby change" do
  #not_if "/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv versions | grep #{node['ruby-env']['version']}"
  #not_if "/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv versions | grep 2.1.2"
  code <<-EOC
  /home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv global 2.1.1
  EOC
end
#execute "source export" do
#  command ". /home/#{node['ruby-env']['user']}/.bash_profile"
#  action :run
#end
#
#execute "ruby change" do
#  not_if "rbenv versions | grep #{node['ruby-env']['version']}"
#  command "rbenv global #{node['ruby-env']['version']} ; rbenv rehash"
#  action :run
#end
