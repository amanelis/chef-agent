require 'yaml'

cookbook_path [ '/root/chef-repo/cookbooks' ]
node_name "signifyd"

knife[:aws_access_key_id] 		= ENV['AWS_ACCESS_KEY_ID']
knife[:aws_secret_access_key]	= ENV['AWS_SECRET_ACCESS_KEY']
