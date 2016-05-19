
include_recipe "yum-repo::default"

rpm_package 'install zabbix release' do
  source 'http://repo.zabbix.com/zabbix/3.0/rhel/6/x86_64/zabbix-release-3.0-1.el6.noarch.rpm'
end


%w{fping curl curl-devel OpenIPMI OpenIPMI-devel net-snmp net-snmp-devel unixODBC unixODBC-devel iksmel iksemel-devel }.each do |pkg|
  package pkg do
    action :install
  end
  
end

#rpm_package 'install zabbix server' do
#  source 'http://repo.zabbix.com/zabbix/3.0/rhel/6/x86_64/zabbix-server-2.4.8-1.el6.x86_64.rpm'
#end

