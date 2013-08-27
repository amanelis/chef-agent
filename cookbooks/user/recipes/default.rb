#
# Cookbook Name:: user
# Recipe:: default
#
# Copyright 2011, Fletcher Nichol
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
user_account 'play' do
	action [:create]
	uid "500"
	gid "501"
	home "/opt/play"
	password "$1$D1nYxR6S$15UWt8uUDEhXggPi3p7GT1"
	ssh_keys [
		node['user']['ssh_keys']['cloudbees'],
		node['user']['ssh_keys']['shaman'],
		node['user']['ssh_keys']['platform']
	]
end











