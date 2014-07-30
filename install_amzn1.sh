#!/bin/bash

# This should always be run as the root user.
# Start: 
# 	base: 	    curl -L https://raw.github.com/amanelis/chef-agent/master/install_amzn1.sh | bash -s base
# 	staging:    curl -L https://raw.github.com/amanelis/chef-agent/master/install_amzn1.sh | bash -s staging
# 	production: curl -L https://raw.github.com/amanelis/chef-agent/master/install_amzn1.sh | bash -s production

case "$1" in
  "")
    echo "USAGE: install.sh {staging|production}"
    RETVAL=1
    exit $RETVAL
    ;;
  base)
   echo "Deploying a basic Platform server"
   env="base"
   ;;
  staging)
   echo "Deploying to Staging Environment"
   env="staging"
   ;;
  production)
   echo "Deploying to Production Environment"
   env="production"
   ;;
esac

chef_binary=/usr/bin/chef-solo
chef_directory=/root/chef-agent

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive

    # House keeping
    cd /root
		
    # System upgrades and package installation
    yum update -y
    yum upgrade -y
    yum groupinstall "Development Tools" -y
    yum install autoconf automake apr-devel apr-util-devel bison bzip2 curl curl-devel git gcc g++ httpd-devel java-1.6.0-openjdk-devel \
    iconv-devel libtool	libffi-devel libyaml-devel make openssl openssl-devel patch readline readline-devel \
    ruby-rdoc ruby-devel sqlite-devel svn zlib zlib-devel -y

    # Install Chef
    curl -L https://www.opscode.com/chef/install.sh | bash
fi &&

# Clone our chef repository
rm -rf $chef_directory
git clone https://github.com/amanelis/chef-agent.git $chef_directory

# Excute Chef-solo
$chef_binary -c $chef_directory/solo.rb -j $chef_directory/roles/$env.json
