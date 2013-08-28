directory "/opt/play" do
	mode "0755"
	action :create
	owner "play"
	group "play"
end

directory "/opt/play/releases" do
	mode "0755"
	action :create
	owner "play"
	group "play"
end

template "/etc/init/platform.conf" do
	source "platform.conf.erb"
	mode 0644
	owner "root"
	group "root"
end

template "/tmp/deployment" do
	source "deployment.erb"
	mode 0755
	owner "root"
	group "play"	
	notifies :run, "execute[deployment]"
end

execute "deployment" do
	user "play"
	group "play"
	command "/tmp/deployment -e staging"
	action :nothing
	not_if { ::File.symlink?('/opt/play/current') }
end
