# xymon-client install
#

filename = "xymon-4.3.10-1.centos6.x86_64.rpm"

cookbook_file "/tmp/#{filename}" do
  source "#{filename}"
end

package "xymon" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{filename}"
end 

service "xymon" do
  action [:enable, :start]
  supports :status => true, :restart => true, :reload => true
end
