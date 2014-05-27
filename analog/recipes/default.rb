#
# Cookbook Name:: analog
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when "centos"
  platform_version = node[:platform_version].to_f

  if platform_version >= 6.0 then
    rpmfile = "analog-6.0.4-1.x86_64.rpm"
  elsif platform_version >= 5.0 then
    rpmfile = "analog-6.0.4-1.al5.i386.rpm"
  else
    raise "This recip can not be applied"
  end

  remote_file "#{Chef::Config[:file_cash_path]}/#{rpmfile}" do
    source "http://www.iddl.vt.edu/~jackie/analog/#{rpmfile}"
  end

  package "analog" do
    action :install
    source "#{Chef::Config[:file_cash_path]}/#{rpmfile}"
    provider Chef::Provider::Package::Rpm
  end
end
