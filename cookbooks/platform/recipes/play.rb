directory "/opt/play" do
	mode "0755"
	action :create
end

directory "/opt/play/releases" do
	mode "0755"
	action :create
end

execute "deployment" do
	command "/tmp/deployment"
	action :run
end
