#!/bin/bash

# This runs as root on the server
# Start: curl -L https://raw.github.com/amanelis/chef-agent/play/install_amzn1.sh | bash

chef_binary=/usr/bin/chef-solo
chef_directory=/root/chef-agent

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive
    
		# House keeping
		cd ~
		
		# System upgrades and package installation
		yum update -y
		yum upgrade -y
		yum groupinstall "Development Tools" -y
		yum install autoconf automake apr-devel apr-util-devel bison bzip2 curl curl-devel git gcc g++ httpd-devel \
		iconv-devel libtool	libffi-devel libyaml-devel make openssl openssl-devel patch readline readline-devel \
		ruby-rdoc ruby-devel sqlite-devel svn zlib zlib-devel -y

		# Install Ruby
		#curl -L https://get.rvm.io | bash -s stable --ruby
		#rm /usr/bin/ruby
		#ln -s /home/ec2-user/.rvm/rubies/ruby-1.9.3-p362/bin/gem /usr/bin/gem
		#ln -s /home/ec2-user/.rvm/rubies/ruby-1.9.3-p362/bin/ruby /usr/bin/ruby
		#ln -s /home/ec2-user/.rvm/bin/rvm /usr/bin/rvm

		# Install Chef
		curl -L https://www.opscode.com/chef/install.sh | bash

		# Clone our chef repository
		git clone https://github.com/amanelis/chef-agent.git

		# Install gems
		# gem install chef ruby-shadow --no-ri --no-rdoc
fi &&

$chef_binary -c $chef_directory/solo.rb -j $chef_directory/platform_amzn1.json
