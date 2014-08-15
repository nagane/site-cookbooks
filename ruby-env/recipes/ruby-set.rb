#
# Cookbook Name:: ruby-env
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


#execute "ruby change" do
#  not_if "/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv versions | grep #{node['ruby-env']['version']}"
#  command "/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv global #{node['ruby-env']['version']} && /home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv rehash"
#  action :run
#end

bash "ruby change" do
  not_if "/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv versions | grep #{node['ruby-env']['version']}"
  code <<-EOC
  /home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv global 2.1.1 
  EOC
end
  #/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv rehash
