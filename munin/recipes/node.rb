# munin node install
#

include_recipe "yum-repo::default"

template '/etc/munin/munin-node.conf' do
  source 'munin-node.conf.erb'
  notifies :restart, 'service[munin-node]'
end

package "munin-node" do
  action :install
  options "--enablerepo=epel"
end

service "munin-node" do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end
