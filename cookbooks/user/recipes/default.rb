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
	action [:create, :manage]
	comment "Platform user 'play'"
	uid 500
	shell "/bin/bash"
	password "$1$D1nYxR6S$15UWt8uUDEhXggPi3p7GT1"
	home "/home/play"
	manage_home true
	ssh_keys [
		"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCU2BS4YVmWMU1Vh5Kiss+QQ4rivxqRVd6T1ELzjaNrKCeMBlr2wzLhB/E4Py1F02PTvxVIqMu5dQUEY73viKv4Sn/41bRybAH2NWnU86Ro/3Ud37m0DL/0uD1aC6JTq88scJtJ8cbF2Wi2dVUiVSNkv1yMh1QXynNLq/mIC9/9DlfZOqIHpEFD30hmRH9/9BZeVDsH5+MdIjn8TBn4kmFlfAsQs51YGBW0bT6Npss0F7B0uFUGq28gy3iSWHguB8PST9GiNo6R5OF5SR6wLUyFTV0+Ku8l+3+wNmKaLSxLKlm4VYRM70v3vEFPRLP5bHCvN17+zwxnWfEZ8ckjdFN3 platform",
		"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4tcJpYKnsop811JWEm0zB5dxVktMumQSfKo+JZDzlWULNelsfrDnDsQ2c76NwSHkTmSTv9z7g4hbP3uRCqnj9yCH7vuryvKkvxyPeCUpoJNEbnSx+NRqTFCjghGLBul2pbOF5MuCZzgekGe1D7h/2mL2QRiB0Azp0nzb98hmAbvmAKd16dg3Jcl9+76sQDJpYhmsSQI6ePLWEtGEqYWHrkXv9pm6dpooLFU4Gd/ic3CFTgpDBz2ldFCYml3a5CO2SavvGceIzZnfs96Aaggm66SQ0ACQqWHdumbe1WXiGD7R8d8wUlfcLcDK6YHGpIdKdJymmnhagZToQ+M91iF3p shaman@shaman.local"
	]
end
