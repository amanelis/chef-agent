#!/bin/bash

# This runs as root on the server
# Start: curl -L https://raw.github.com/amanelis/chef-agent/play/install_ubuntu.sh | bash

chef_binary=/usr/bin/chef-solo
chef_directory=/root/chef-agent

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive
    
		# House keeping
		cd ~
		adduser ubuntu root
		adduser ubuntu sudo	

		# Install Ruby
		apt-get install ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 -y 
		apt-get install libopenssl-ruby1.9.1 libssl-dev zlib1g-dev -y

		update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 \
		--slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz /usr/share/man/man1/ruby1.9.1.1.gz \
		--slave   /usr/bin/ri ri /usr/bin/ri1.9.1 \
		--slave   /usr/bin/irb irb /usr/bin/irb1.9.1 \
		--slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1

		update-alternatives --set ruby /usr/bin/ruby1.9.1
		update-alternatives --set gem  /usr/bin/gem1.8
    
		# Install Chef
		curl -L https://www.opscode.com/chef/install.sh | bash

		# Clone our chef repository
		git clone https://github.com/amanelis/chef-agent.git && cd chef-agent

		# Install gems
		gem install chef ruby-shadow --no-ri --no-rdoc
	
fi &&
$chef_binary -c $chef_directory/solo.rb -j $chef_directory/platform_ubuntu.json
