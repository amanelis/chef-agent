case node[:platform]
  when "debian", "ubuntu"
  when "centos", "redhat", "amazon", "scientific"
		# Install rubygems 
		remote_file "#{Chef::Config[:file_cache_path]}/rubygems-1.8.24.tgz" do
			source "http://rubyforge.org/frs/download.php/76073/rubygems-1.8.24.tgz"
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
		end  
	end




