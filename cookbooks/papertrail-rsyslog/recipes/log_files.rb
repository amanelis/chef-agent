template "/etc/init.d/remote_syslog" do
  source "remote_syslog.erb"
  mode "0775"		
end

template '/etc/log_files.yml' do
  source "log_files.yml.erb"
  # notifies :restart, 'service[remote_syslog]', :delayed
end

bash "append_host_port_to_rsyslog" do
  code <<-EOF
    echo "*.* @logs.papertrailapp.com:#{node['papertrail']['port']}" >> /etc/rsyslog.conf
  EOF
  not_if { ::File.readlines('/etc/rsyslog.conf').grep(/logs.papertrailapp.com/).size == 1 }
  # notifies :restart, "service[remote_syslog]", :delayed
end

# service "remote_syslog" do
#   action [:enable, :start, :restart]
# end
