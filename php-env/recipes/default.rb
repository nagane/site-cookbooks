#
# Cookbook Name:: php-env
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{php-devel php-fpm php php-mbstring php-gd php-pear php-xml php-mysql}.each do |pkg|
  package pkg do
    action :install
    notifies :restart, "service[php-fpm]"
  end
end

service "php-fpm" do
  action [:enable, :start]
end
