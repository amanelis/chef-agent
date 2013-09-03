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
