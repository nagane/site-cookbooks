#
# Cookbook Name:: setup-user
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

accounts = data_bag('user_accounts')

#user 'nagane' do
#  password "$1$pzGiCXcX$04QsjWWwNCzPS.lWuTdFL0"
#  supports :manage_home => true
#  action [:create]
#end

accounts.each do |id|

  item = data_bag_item('user_accounts', id)
  
  item['users'].each do |u|

    node['setup-user']['add-user'].each do |addu|

      if addu == u['name']
        user u['name'] do
          password u['password']
          supports :manage_home => true
          action :create
        end
        
        group 'wheel' do
          action [:modify]
          members u['name']
          append true
        end
      end
    end
  end
end
