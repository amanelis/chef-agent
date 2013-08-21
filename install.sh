#!/bin/bash

# This runs as root on the server

chef_binary=/usr/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive
    
		# House keeping
		cd ~
		adduser ubuntu root
		adduser ubuntu sudo	

		# Upgrade headlessly (this is only safe-ish on vanilla systems)
    aptitude update && apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade
		apt-get update -y && apt-get upgrade -y && apt-get install git-core build-essential curl wget -y

		# Install Chef
		curl -L https://www.opscode.com/chef/install.sh | bash

		# Clone our chef repository
		git clone https://github.com/amanelis/chef-agent.git && cd chef-agent
	
fi &&

"$chef_binary" -c solo.rb -j platform.json
