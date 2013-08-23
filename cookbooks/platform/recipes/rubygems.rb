# Install rubygems 
remote_file "#{Chef::Config[:file_cache_path]}/rubygems-1.8.24.tgz" do
	source "http://rubyforge.org/frs/download.php/76073/rubygems-1.8.24.tgz"
	action :create_if_missing
end

bash "install_rubygems" do
	cwd Che::Config[:file_cache_path]
	code <<-EOH
		tar zxf rubygems-1.8.24.tgz
		cd rubygems-1.8.24.tgz
		/usr/bin/ruby setup.rb
		yum install gcc g++ make automake autoconf curl-devel openssl-devel \
		zlib-devel httpd-devel apr-devel apr-util-devel sqlite-devel -y \
		ruby-rdoc ruby-devel -y
	EOH
end
