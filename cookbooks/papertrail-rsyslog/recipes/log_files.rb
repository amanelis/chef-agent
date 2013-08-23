bash "append_host_port_to_rsyslog" do
	code <<-EOF
		echo "*.*          @logs.papertrailapp.com:40007" >> /etc/rsyslog.conf
	EOF
	notifies :restart, "service[remote_syslog]", :immediately
end

service "remote_syslog" do
	action [:enable, :start, :restart]
end
