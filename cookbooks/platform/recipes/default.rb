#
# Cookbook Name:: platform
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'monit'
service 'monit' do
  action [:enable, :start]
end

package 'ntp'
template '/etc/ntp.conf' do
  source    'ntp.conf.erb'
  notifies  :restart, 'service[ntp]'
end
template '/etc/init.d/ntp' do
	source 		'ntp.erb'
	notifies :restart, 'service[ntp]'
end
service 'ntp' do
  action [:enable, :start]
end
