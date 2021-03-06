# Chef Solo

## Introduction
This package is used to deploy a new node to a given environment on a newly created EC2 instance. To see what packages are being installed be sure to have a look at the run lists associated with this Chef Solo package here: `roles/{staging|production}.json`

These packages that are specified in the run list can be found in `cookbooks/` and they contain all of the `cookbooks/{cookbook}/recipes/*` code that is specified in the run list to be installed on the new system. Recipes are where commands and configuration for the system are defined. 

## Dependencies and Assumptions
Before getting started using these commands, we assume that you have the [Amazon EC2 Tools] package installed. Do not continue unless it is fully installed and functional. Follow the steps here ([Amazon EC2 Tools]) to get started. 

You need to have these setup with a valid AWS access_key_id and an access_secret_key to work and function with the account you want to boot instances to. 

You will also need your EC2 key pair. In this demonstration we will assume its called `mykey.pem`.

## Creating a valid and ready instance
To start, be sure you can run the command `ec2-run-instances` on your machine with no arguments. Next we need to run this with 3 arguments to build a correct instance. You'll want to give it our default build image of `ami-9f1855f6` the key name of `mykey` the security group `www` and the zone `us-east-1d`. 

	$ ec2-run-instances ami-971758fe -k mykey -g www -z us-east-1d
	$ aws run-instance ami-971758fe -i m1.small -k platform -g www -z us-east-1d
	
This command will return to you a detailed output of the newly created instance. There will be a line in there that contains the instance ID, it should look something like this:

	$ INSTANCE	i-XXXXXXX…

Take the instance ID given and run this command to get the public domain so you can then SSH into the machine:

	$ ec2-describe-instances i-XXXXXXX

Name your newly created insance

	$ ec2addtag i-XXXXXX --tag Name=my-new-instance

Look in the output for your public dns domain name that should look like this:

	ec2-100-20-20-101.compute-1.amazonaws.com
	
Take that domain name and SSH into the newly created instance:

	$ ssh -i mykey.pem ec2-user@ec2-100-20-20-101.compute-1.amazonaws.com

Once ssh'd into the machine you should change to the root user:

	$ sudo su
	$ cd ~
	
Now comes the fun part, downloading and running chef. This next command does a lot, so please reference the script if there are any concerns to what is going on. Do be conscious of what environment you are running the script as. Pick your environment:

#### Staging

	$ curl -L https://raw.github.com/signifyd/chef-agent/play/install_amzn1.sh | bash -s staging
	
#### Production

	$ curl -L https://raw.github.com/signifyd/chef-agent/play/install_amzn1.sh | bash -s production

## Using Knife
This section is experimental. Reference the [Knife AWS] docs or read the [Knife Github] source for the optional command line arguments. Trying to get the `knife` package to boot the entire image, but getting certificate errors. Be sure to run `bundle install` before running this command. You will also need to set an envrionment varibale of the following. 

	$ export AWS_ACCESS_KEY_ID='YOUR-KEY'
	$ export AWS_SECRET_ACCESS_KEY='YOUR-SECRET'

Here is an example command:

	$ knife ec2 server create -r 'role[staging]' -I ami-9f1855f6 -f m1.small -S platform -G www -N platform-staging-0X
	$ knife ec2 server create -r 'role[production]' -I ami-9f1855f6 -f m1.small -S platform -G www -N platform-production-0X

[Amazon EC2 Tools]: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SettingUp_CommandLine.html
[Perl AWS Tools]: http://timkay.com/aws/
[Knife AWS]: http://docs.opscode.com/plugin_knife_ec2.html
[Knife Github]: https://github.com/opscode/knife-ec2
[Knife Server Github]: https://github.com/fnichol/knife-server
