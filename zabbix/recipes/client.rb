
rpm_package 'install zabbix release' do
  source 'http://repo.zabbix.com/zabbix/3.0/rhel/6/x86_64/zabbix-release-3.0-1.el6.noarch.rpm'
end

%w{ zabbix-agent zabbix-sender }.each do |pkg|
  package pkg do
    action :install
  end
end

service "zabbix-agent" do
  action [ :enable, :start ]
end

template '/etc/zabbix/zabbix_agentd.conf' do
  source 'zabbix_agentd.conf.erb'
  notifies :restart, "service[zabbix-agent]"
end

