#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2009-2012, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Empty default recipe for including LWRPs.
group "ec2-user" do
	gid 500
end

group "play" do
  gid 501
end

template "/etc/sudoers" do
	source "sudoers.erb"
	mode 0440
	owner "root"
	group "root"
end

#user "root" do
#  action :manage
#	password "$1$cV1BnEQ8$PQvZKfh22dIhVVdsL9dNr1"
#end

#user "play" do
#	action [:create, :manage]
#	comment "Platform user 'play'"
#	uid 500
#	gid 501
#	home "/opt/play"
#	manage_home true
#	password "$1$cV1BnEQ8$PQvZKfh22dIhVVdsL9dNr1"
#end

#user "ec2-user" do
#	action [:create, :manage]
#	comment "Platform user 'ec2-user'"
#	uid 222
#	gid 500
#	home "/home/ec2-user"
#	manage_home true
#	password "$1$cV1BnEQ8$PQvZKfh22dIhVVdsL9dNr1"
#end