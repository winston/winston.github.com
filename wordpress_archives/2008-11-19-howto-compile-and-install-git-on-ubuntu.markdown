--- 
layout: post
title: HOWTO Compile And Install Git On Ubuntu
wordpress_id: 213
wordpress_url: http://www.winstonyw.com/?p=213
date: 2008-11-19 23:40:23 +08:00
---
This is a Google Notebook dump of how to compile and install Git on Ubuntu (or Linux), as my Google Notebook is cluttered with random knowledge that I picked up in my work and is in need of some organization.

<h3>Step 1: Download Dependencies</h3> 
There are dependencies that's required for the install of Git. Let's get them via apt-get.
[code='bash']
sudo apt-get build-dep git-core
[/code]

<strong>Note</strong>: If apt-get fails at some point to install the dependencies, update it and retry.
[code='bash']
sudo apt-get update 
[/code]

<h3>Step 2: Download Git</h3>
Download the latest version of Git. I use <em>wget</em>, but it's really up to personal preference.
[code='bash']
wget http://kernel.org/pub/software/scm/git/git-1.6.0.4.tar.gz
[/code]

<h3>Step 3: Make and Install Git</h3>
Simply execute the following commands to unpack, compile and install Git.
[code='bash']
gunzip git-1.6.0.4.tar.gz
tar -xvf git-1.6.0.4.tar
cd git-1.6.0.4
./configure
make && sudo make install
[/code]

That's all to get started with Git on your Ubuntu (or Linux) servers. Enjoy!
