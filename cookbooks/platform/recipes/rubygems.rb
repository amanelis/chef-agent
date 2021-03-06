case node[:platform]
  when "debian", "ubuntu"
  when "centos", "redhat", "amazon", "scientific"
		remote_file "#{Chef::Config[:file_cache_path]}/rubygems-1.8.24.tgz" do
			source "https://s3.amazonaws.com/com.signifyd.repositories/rubygems/rubygems-1.8.24.tgz"
			action :create_if_missing
		end

		bash "install_rubygems" do
			cwd Chef::Config[:file_cache_path]
			code <<-EOH
				tar -zxf rubygems-*.tgz
				cd rubygems-1.8*
				/usr/bin/ruby setup.rb
			EOH
			action :run
			not_if { ::File.exists?("/usr/bin/gem") }
		end  

		execute "rubygem-aws-sdk" do
			user "root"
			command "yum install rubygem-aws-sdk -y"
			action :run
		end

		gem_package "remote_syslog" do
			action :install
			options("--no-ri --no-rdoc")
		end

		gem_package "aws-s3" do
			action :install
			options("--no-ri --no-rdoc")
		end	

		gem_package "aws-sdk" do
			action :install
			options("--no-ri --no-rdoc")
		end
		
		gem_package "ohai" do
		  action :install
		  options("--no-ri --no-rdoc")
	  end
	end