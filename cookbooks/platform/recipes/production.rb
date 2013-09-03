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
	command "/tmp/deployment -e production"
	action :nothing
	not_if { ::File.symlink?('/opt/play/current') }
end
