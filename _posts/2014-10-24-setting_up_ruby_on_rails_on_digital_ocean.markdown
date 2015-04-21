---
layout: post
title: Setting Up Ruby on Rails On Digital Ocean
---

**Edit** This has been updated for Ubuntu 14.10, Ruby 2.2.2 and Postgres 9.4.

Documentation of how I setup [SGBusFeedback.com](http://www.sgbusfeedback.com),
a basic Ruby on Rails application backed by a PostgreSQL database on Digital Ocean.

Noting it down for my future self.


## Create Droplet on Digital Ocean

- Login to Digital Ocean and start `Create`-ing a Droplet
- Size		: $5/mth
- Region	: Singapore
- Image		: Linux Distribtions > Ubuntu 14.04 x64
- Add SSH key for easy access to the Droplet
- `Create Droplet`!


## Set Up Droplet

Assuming that your SSH key has been set up properly, SSH into your Droplet.

````
machine$> ssh root@<ipaddress>
````


### Add a Deploy User

Create a `deploy` user on the Droplet.

````
droplet$> sudo adduser deploy
droplet$> sudo adduser deploy sudo #add to sudo group
````

Create a SSH key on your machine, and upload the key.

````
machine$> ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/winston/.ssh/id_rsa): id_deploy_digital_ocean
...
````
Copy the SSH key to the Droplet.

On Mac? `brew install ssh-copy-id`. On Linux? You already have `ssh-copy-id`.

````
machine$> ssh-copy-id -i ~/.ssh/id_deploy_digital_ocean deploy@<ipaddress>
````

Now you can login to your Droplet with:

````
machine$> ssh-add ~/.ssh/id_deploy_digital_ocean
machine$> ssh deploy@<ipaddress>
````


### Harden Droplet

Modify SSH settings `/etc/ssh/sshd_config` in the Droplet.


- Add `PermitRootLogin without-password` ([What?](http://askubuntu.com/questions/449364/what-does-without-password-mean-in-sshd-config-file))
- Add `UseDNS no` ([What?](http://unix.stackexchange.com/questions/56941/what-is-the-point-of-sshd-usedns-option))
- Change `Port` to something unique and take note. E.g. `8888`

Reload SSH with `reload ssh`.

Verify your SSH settings with your new user. In a new Terminal:

````
machine$> ssh -p 8888 deploy@<ipaddress>
````

Bonus. Add this to `~/.ssh/config` on your machine so that login will be a breeze.

````
# in ~/.ssh/config
Host	<appname>
	HostName		<ipaddress>
	Port			8888
	User			deploy
	IdentityFile 	~/.ssh/id_deploy_digital_ocean
````

````
machine$> ssh <appname>
````


### Update and Upgrade Ubuntu

A Ruby on Rails server requires quite a few things. Installed these as the `deploy` user.

````
droplet$> sudo apt-get update
droplet$> sudo apt-get upgrade
droplet$> sudo apt-get install git-core
droplet$> sudo apt-get install nodejs # for assets compilation.
````


### RVM

Install RVM.

````
droplet$> curl -L https://get.rvm.io | bash -s stable
# If an error about gpg occurs, follow the instructions..
droplet$> gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
# https://github.com/wayneeseguin/rvm/issues/3110
````

Relogin to shell, install RVM requirements, and Ruby.

````
droplet$> source /etc/profile.d/rvm.sh
droplet$> echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc
droplet$> rvm requirements
droplet$> rvm install 2.2.2
droplet$> rvm use 2.2.2 --default
droplet$> ruby -v
````


### RubyGems Setup

Prevent RubyGems from installing docs.

````
droplet$> echo "gem: --no-ri --no-rdoc" > ~/.gemrc
````


### Install Nginx and Passenger

Follow the instructions on the [Official Documentation](https://www.phusionpassenger.com/documentation/Users%20guide%20Nginx.html#installation).

#### Condensed Version:

Install Phusion's PGP key and add HTTPS support for ATP.

````
droplet$> sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
droplet$> sudo apt-get install apt-transport-https ca-certificates
````

Add Passenger's repository. *__Just one.__*

````
droplet$> sudo sh -c 'echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" >> /etc/apt/sources.list.d/passenger.list'
droplet$> sudo chown root: /etc/apt/sources.list.d/passenger.list
droplet$> sudo chmod 600 /etc/apt/sources.list.d/passenger.list
droplet$> sudo apt-get update
````

Install Nginx and Passenger packages.

````
# The Official Documentation uses `nginx-extras` but `nginx-full` is good enough.
droplet$> sudo apt-get install nginx-full passenger
````

Edit `/etc/nginx/nginx.conf` and uncomment `passenger_root` and `passenger_ruby`.

Also find out where your `ruby` is, and use that for `passenger_ruby`.

````
droplet$> passenger-config --ruby-command
  Command: /usr/local/rvm/gems/ruby-2.2.2/wrappers/ruby
  Version: ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-linux]
  To use in Apache: PassengerRuby /usr/local/rvm/gems/ruby-2.2.2/wrappers/ruby
  To use in Nginx : passenger_ruby /usr/local/rvm/gems/ruby-2.2.2/wrappers/ruby
  To use with Standalone: /usr/local/rvm/gems/ruby-2.2.2/wrappers/ruby /usr/bin/passenger start
````

````
droplet$> sudo vi /etc/nginx/nginx.conf
... Edits ..
droplet$> sudo service nginx restart
````

### Install PostgreSQL

Install it.

````
droplet$> sudo apt-get install postgresql-9.4 libpq-dev
````

Set up Postgres user.

The `password` that you used here will be used in your app's `database.yml`.

````
droplet$> sudo su - postgres
droplet$> psql -c"alter user postgres with password 'strong123password';"
````

Create the Production database.

````
droplet$> psql
psql> create database <production_dbname>;
psql> exit
````

### Connect GitHub Repo to Droplet

Create a SSH key on the Droplet, and then add it to the GitHub repo.

Follow the instructions here: [https://help.github.com/articles/generating-ssh-keys/](https://help.github.com/articles/generating-ssh-keys/)

Make sure you run this `droplet$> ssh -T git@github.com`.

This will ensure that Mina can deploy with GitHub.

### Setup Mina

Follow the instructions on [Mina's README](https://github.com/mina-deploy/mina).

#### Condensed Version:

Init Mina on your application.

````
machine$> mina init
Created config/deploy.rb.
````

Use `rvm` or `rbenv`.

````
require 'mina/rvm'
# require 'mina/rbenv'
````

Update `config/deploy.rb` with Droplet's Details.

````
set :domain,	   <ipaddress>
set :deploy_to,   '/home/deploy/<app_domain'
set :repository,  'git@github.com:<user>/<repo>.git'
set :branch,      'master'
set :user,        'deploy'
set :port,        '8888'
....
task :environment do
  queue 'source ~/.bash_profile'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use[ruby-2.1.4]'
end
````

SetUp Mina on Droplet.

````
machine$> mina setup
-----> Using RVM environment 'ruby-2.1.4'
       Using /home/demo/.rvm/gems/ruby-2.1.4
-----> Setting up /home/deploy/<app_domain>

       total 16
       drwxrwxr-x 4 deploy deploy 4096 Nov  5 02:00 .
       drwxr-xr-x 8 deploy deploy 4096 Nov  5 02:00 ..
       drwxrwxr-x 2 deploy deploy 4096 Nov  5 02:00 releases
       drwxrwxr-x 4 deploy deploy 4096 Nov  5 02:00 shared

-----> Done.
-----> Be sure to edit 'shared/config/database.yml'.
-----> Be sure to edit 'shared/config/secrets.yml'.
       Elapsed time: 1.00 seconds
````

*__Important!__* Update `shared/config/database.yml` and `shared/config/secrets.yml` on the Droplet.

````
#database.yml
production:
	adapter: postgresql
	encoding: unicode
	database: <production_dbname>
	username: postgres
	password: strong123password
	host: localhost
````

```
#secrets.yml
production:
	secret_key_base: <Generated from `rake secret`>
```

You might also need these settings in `.bash_profile`.

````
# vi .bash_profile
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
````

Now, you can deploy your application to the Droplet.

````
machine$> mina deploy
````

### Update Nginx Configuration

Update the file `/etc/nginx/sites-enabled/default` with these settings:

````
server {
	listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    server_name 		<app_domain>;
    passenger_enabled 	on;
    rails_env    		production;
    root         		/home/deploy/<app_domain>/current/public;
}
````

Restart the Nginx server, you should be able to see your app at the `ipaddress`.

````
droplet$> sudo service nginx restart
````

### Next Steps

At this point, you already have your app up and running at `ipaddress`.

You will probably need to do the following to make it work nicely:

- Use `figaro` or add ENV variables to `.bash_profile`.
- Point DNS to the `ipaddress`.
- Explore other configurations for your Nginx (static 40* or 50*)
- Put in place backup strategies for your PostgreSQL (maybe use RDS instead?)

That's it!

### Troubleshooting

Sometimes, the $5/mth Droplet might complain of inadequate swap space. [Read this](https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-12-04).

Also, Nginx error logs are pretty handy. Available at `/var/log/nginx/error.log`.


## Resources

Reading these really helped!

- [Initial Server Setup with Ubuntu 12.04](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-12-04)
- [Deploy Ruby On Rails on Ubuntu 14.04 Trusty Tahr](https://gorails.com/deploy/ubuntu/14.04)
- [https://gist.github.com/sathishmanohar/5491263](https://gist.github.com/sathishmanohar/5491263)
- [Deploying a Rails app on Ubuntu 14.04 - Passenger, RBenv, PostgreSQL, and Mina](http://voiceofchunk.com/2014/06/09/deploying-rails-apps-using-passenger-rbenv-postgresql-and-mina/)
