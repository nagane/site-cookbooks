
#include_recipe "yum-repo::default"

rpm_package 'install zabbix release' do
  source 'http://repo.zabbix.com/zabbix/3.0/rhel/6/x86_64/zabbix-release-3.0-1.el6.noarch.rpm'
end


%w{fping curl curl-devel OpenIPMI OpenIPMI-devel net-snmp net-snmp-devel unixODBC unixODBC-devel zabbix-server-mysql zabbix-web-mysql zabbix-web-japanese }.each do |pkg|
  package pkg do
    action :install
  end
end

execute "create mysql db" do
  command "mysql -e \"create database zabbix;\""
  not_if "mysql -e \"show databases;\" |grep zabbix"
end

execute "create mysql recorde" do
  command "zcat /usr/share/doc/zabbix-server-mysql-3.0.2/create.sql.gz | mysql -uroot zabbix"
  only_if { File.directory?("/usr/share/doc/zabbix-server-mysql-3.0.2")}
end
