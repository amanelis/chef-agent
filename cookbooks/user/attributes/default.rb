#
# Cookbook Name:: user
# Attributes:: default
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
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

case platform
when 'debian','ubuntu','redhat','centos','amazon','scientific','fedora','freebsd','suse'
  default['user']['home_root']      = "/home"
  default['user']['default_shell']  = "/bin/bash"
when 'openbsd'
  default['user']['home_root']      = "/home"
  default['user']['default_shell']  = "/bin/ksh"
when 'mac_os_x', 'mac_os_x_server'
  default['user']['home_root']      = "/Users"
  default['user']['default_shell']  = "/bin/bash"
else
  default['user']['home_root']      = "/home"
  default['user']['default_shell']  = nil
end

default['user']['manage_home']        = "true"
default['user']['create_user_group']  = "true"
default['user']['ssh_keygen']         = "true"

default['user']['ssh_keys']['shaman'] = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4tcJpYKnsop811JWEm0zB5dxVktMumQSfKo+JZDzlWULNelsfrDnDsQ2c76NwSHkTmSTv9z7g4hbP3uRCqnj9yCH7vuryvKkvxyPeCUpoJNEbnSx+NRqTFCjghGLBul2pbOF5MuCZzgekGe1D7h/2mL2QRiB0Azp0nzb98hmAbvmAKd16dg3Jcl9+76sQDJpYhmsSQI6ePLWEtGEqYWHrkXv9pm6dpooLFU4Gd/ic3CFTgpDBz2ldFCYml3a5CO2SavvGceIzZnfs96Aaggm66SQ0ACQqWHdumbe1WXiGD7R8d8wUlfcLcDK6YHGpIdKdJymmnhagZToQ+M91iF3p shaman@shaman.local"

default['user']['ssh_keys']['platform'] = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCU2BS4YVmWMU1Vh5Kiss+QQ4rivxqRVd6T1ELzjaNrKCeMBlr2wzLhB/E4Py1F02PTvxVIqMu5dQUEY73viKv4Sn/41bRybAH2NWnU86Ro/3Ud37m0DL/0uD1aC6JTq88scJtJ8cbF2Wi2dVUiVSNkv1yMh1QXynNLq/mIC9/9DlfZOqIHpEFD30hmRH9/9BZeVDsH5+MdIjn8TBn4kmFlfAsQs51YGBW0bT6Npss0F7B0uFUGq28gy3iSWHguB8PST9GiNo6R5OF5SR6wLUyFTV0+Ku8l+3+wNmKaLSxLKlm4VYRM70v3vEFPRLP5bHCvN17+zwxnWfEZ8ckjdFN3 platform"

default['user']['ssh_keys']['cloudbees'] = "ssh-dss AAAAB3NzaC1kc3MAAACBAO2sox4QGuJRi2iODKoe/XHyz8BN4zCp6rwmjVgVh+ItDkJbuyyO9nK4sFRaQgjwEi1ng3/m/lESf0aLHjhVmGGbsjvmA8sqtu1n8pWGdL8Rv+5h6zw/8G/ZYGuXnLf8URqh0rrdrTuW6XfBy+JW0rrlOMs+eGu6LR/8krVPv/Y9AAAAFQDck8KVpRinrFU0FT/qf/nSawynWwAAAIBacswfMjzWMONfwFi7tbC9D9P1D7x5s9i0M+Dgh4XXwYBnZDKJJupGql+Vt5yYohuDQtiVgf9ZYmwYVtHaH5CpVjJfQrStwk87Trkj/Gq6kHVl4cSAu8Rl2mTBNLd12xpDRpCG26/o4kvZLEYG3SVnUphhnwb0siMWEq2/xGyBhAAAAIEA6bF7CPw+kHxefXf0Ka2kb5lYRMk5Ry+W/dv4VL51p1LA9kMJPi0w2lcgyt4WoenmaQxIrBGk2+YrvjUIZirjQpaqEfNfXnHlJmlavM6IoY12ETpirdjx4LwQt+xFEo1QqmaZrW6R9ev0YXutdSubSjaUVIVrg8Ji+dnTF2aRQfE= signifyd"
