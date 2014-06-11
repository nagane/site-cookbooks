#
# Cookbook Name:: fluentd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

  # install from rpm(omnibus installer)
  execute "install td-agent by using rpm" do
    command "curl -L http://toolbelt.treasure-data.com/sh/install-redhat.sh | sh"
  end
  
  service "td-agent" do
    action [:enable, :start]
  end
