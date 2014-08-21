# xymon-client install
#

filename = "xymon-client-4.3.10-1-centos5.x86_64.rpm"

cookbook_file "/tmp/#{filename}" do
  source "#{filename}"
end

package "xymon-client" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{filename}"
end 
