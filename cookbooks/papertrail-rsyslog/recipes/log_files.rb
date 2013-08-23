file '/etc/log_files.yml' do
	source "log_files.yml.erb"
	notifies :restart, 'service[remote_syslog]', :delayed
end

template "/etc/init.d/remote_syslog" do
	source "remote_syslog.erb"
	mode "0775"		
end

bash "append_host_port_to_rsyslog" do
	code <<-EOF
		echo "*.*          @logs.papertrailapp.com:40007" >> /etc/rsyslog.conf
	EOF
	notifies :restart, "service[remote_syslog]", :delayed
end

service "remote_syslog" do
	action [:enable, :start, :restart]
end
