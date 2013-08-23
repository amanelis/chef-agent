papertrail_port = node[:papertrail][:port] or raise 'Must set papertrail port!'

# include_recipe 'apt'
# package 'libssl-dev' 

gem_package 'remote_syslog'

log_files_conf = '/etc/log_files.yml'

file log_files_conf do
  content <<-YAML
    files:
#{node[:papertrail][:log_files].map {|file| "      - #{file}" }.join("\n")}
    destination:
      host: logs.papertrailapp.com
      port: #{papertrail_port}
  YAML

  notifies :restart, 'service[remote_syslog]', :delayed
end

file '/etc/init/remote_syslog.conf' do
  content <<-UPSTART
description "Monitor files and send to remote syslog"
start on runlevel [2345]
stop on runlevel [!2345]

respawn

pre-start exec /usr/bin/test -e #{log_files_conf}

exec /usr/local/bin/remote_syslog -D --tls
  UPSTART

  notifies :restart, 'service[remote_syslog]', :delayed
end

#execute "start remote_syslog" do
#	command "/usr/bin/ruby1.8 /usr/bin/remote_syslog -D --tls"
#end

service 'remote_syslog' do
  action :start
  #provider Chef::Provider::Service::Upstart
end
