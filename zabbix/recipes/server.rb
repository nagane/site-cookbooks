
include_recipe "yum-repo::default"

rpm_package 'install zabbix release' do
  source 'http://repo.zabbix.com/zabbix/3.0/rhel/6/x86_64/zabbix-release-3.0-1.el6.noarch.rpm'
end

%w{php php-devel php-gd php-bcmath php-mysql php-mbstring php-xml}.each do |pkg|
  package pkg do
    action :install
    options "--enablerepo=remi-php56"
  end
end

execute "insert time.zone to php.ini" do
  command "echo \'date.timezone = Asia Tokyo\' >> /etc/php.ini"
  only_if { File.exists?("/etc/php.ini")}
  not_if "grep ^date.timezone /etc/php.ini"
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

# 飽きてきたのでTODOだけ残して終る
# 
# 1. /etc/httpd/conf.d/zabbix.conf に下記内容を記載
# 
# ```
# Alias /zabbix /usr/share/zabbix
# 
# php_value max_execution_time 300
# php_value memory_limit 128M
# php_value post_max_size 16M
# php_value upload_max_filesize 2M
# php_value max_input_time 300
# php_value always_populate_raw_post_data -1
# # php_value date.timezone Europe/Riga
# ```
# 
# 2. /etc/zabbix/zabbix_server.conf に下記内容を記載
# 
# ```
# DBHost=localhost
# DBName=zabbix
# DBUser=zabbix
# DBPassword=zabbix
# ```
# 後はhttpdのインストールとか
#

