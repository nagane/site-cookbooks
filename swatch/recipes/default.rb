#
# Cookbook Name:: swatch
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


%w{atd swatch}.each do |pkg|
  package pkg do
    action :install
  end
end
