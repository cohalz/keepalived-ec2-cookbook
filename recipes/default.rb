#
# Cookbook Name:: keepalived-ec2
# Recipe:: default
#
# Copyright 2018, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
raise "Attribute: 'keepalived-ec2' is not defined." if node['keepalived-ec2'].nil?
raise "Attribute: 'bag_name' is not defined." if node['keepalived-ec2']['bag_name'].nil?
raise "Attribute: 'item_name' is not defined." if node['keepalived-ec2']['item_name'].nil?
raise "Attribute: 'chk_script' is not defined." if node['keepalived-ec2']['chk_script'].nil?
raise "Attribute: 'eni' is not defined." if node['keepalived-ec2']['eni'].nil?
raise "Attribute: 'device_index' is not defined." if node['keepalived-ec2']['device_index'].nil?
raise "Attribute: 'interface' is not defined." if node['keepalived-ec2']['interface'].nil?
raise "Attribute: 'state' is not defined." if node['keepalived-ec2']['state'].nil?
raise "Attribute: 'virtual_router_id' is not defined." if node['keepalived-ec2']['virtual_router_id'].nil?
raise "Attribute: 'master_ip' is not defined." if node['keepalived-ec2']['master_ip'].nil?
raise "Attribute: 'backup_ip' is not defined." if node['keepalived-ec2']['backup_ip'].nil?

bash 'install grabeni' do
  user 'root'
  cwd  '/home/ec2-user'
  code <<-EOH
    wget https://github.com/yuuki/grabeni/releases/download/v0.4.2/grabeni_linux_amd64.tar.gz
    tar zxfv grabeni_linux_amd64.tar.gz
    mv grabeni_linux_amd64/grabeni /usr/bin/
    rm -rf grabeni_linux_amd64/
    chmod +x /usr/bin/grabeni
  EOH
  not_if { ::File.exist?('/home/ec2-user/grabeni_linux_amd64.tar.gz') }
end

credentials = Chef::EncryptedDataBagItem.load("#{node['keepalived-ec2']['bag_name']}","#{node['keepalived-ec2']['item_name']}")

include_recipe 'keepalived'

template '/etc/keepalived/master.sh' do
  source 'master.sh.erb'
  mode '0755'
  variables ({
    :access_key => credentials['AWS_ACCESS_KEY_ID'],
    :secret_access_key => credentials['AWS_SECRET_ACCESS_KEY'],
    :region => credentials['AWS_REGION']
  })
  notifies :restart, "service[keepalived]", :immediately
end

case node['keepalived-ec2']['state']
  when "MASTER" then
    priority = 101
    src = node['keepalived-ec2']['master_ip']
    peer = node['keepalived-ec2']['backup_ip']
  when "BACKUP" then
    priority = 100
    src = node['keepalived-ec2']['backup_ip']
    peer = node['keepalived-ec2']['master_ip']
  else
    raise "Attribute: 'state' must be 'MASTER' or 'BACKUP'."
end

template '/etc/keepalived/conf.d/keepalived.conf' do
  source node['keepalived-ec2']['conf_template']
    variables ({
    :priority => priority,
    :src => src,
    :peer => peer
  })
  notifies :restart, "service[keepalived]", :immediately
end

service "keepalived" do
  supports :start => true,:realod => true, :restart => true, :enable => true
end
