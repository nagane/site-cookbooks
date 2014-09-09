# xymon-client install
#

filename = "xymon-client-4.3.10-1-centos6.x86_64.rpm"

cookbook_file "/tmp/#{filename}" do
  source "#{filename}"
end

package "xymon-client" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{filename}"
end 

template '/etc/default/xymon-client' do
  source 'xymon-client.erb'
  owner 'xymon'
  group 'xymon'
  mode '0644'
  notifies :restart, 'service[xymon-client]'
end

service "xymon-client" do
  action [:enable, :start]
  supports :status => true, :restart => true, :reload => true
end
