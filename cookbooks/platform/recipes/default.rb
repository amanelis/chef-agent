#
# Cookbook Name:: platform
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#remote_file "#{Chef::Config[:file_cache_path]}/ruby-1.9.3-p194.tar.gz" do
#	source "http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz"
#	action :create_if_missing
#end
#
#bash "compile_ruby_source" do
#	cwd Chef::Config[:file_cache_path]
#	code <<-EOH
#		tar zxf ruby-1.9.3-p194.tar.gz
#		cd ruby-1.9.3-p194
#		./configure
#		make && make install
#	EOH
#end

# include_recipe "platform::rubygems"
