directory "/opt/play" do
	mode "0755"
	action :create
	owner "play"
end

directory "/opt/play/releases" do
	mode "0755"
	action :create
	owner "play"
end

execute "deployment" do
	user "play"
	command "/tmp/deployment"
	action :nothing
end
