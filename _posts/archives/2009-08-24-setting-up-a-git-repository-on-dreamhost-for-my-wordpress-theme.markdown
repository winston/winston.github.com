--- 
layout: post
title: Setting Up A Git Repository On Dreamhost For My WordPress Theme
wordpress_id: 271
wordpress_url: http://www.winstonyw.com/?p=271
date: 2009-08-24 23:57:13 +08:00
---
For any Dreamhost questions, I always refer to the <a href="http://wiki.dreamhost.com">Wiki</a> which is excellently compiled. However, I realised that the Wiki has either an outdated answer or simply failed to answer the question of "How to set up a Git Repository on your Dreamhost account". Thus you can sort of <a href="http://wiki.dreamhost.com/Git">ignore this page on the Wiki</a>.

My goal is to set up a private repository for <a href="http://github.com/winston/winstonyw/tree/master">my own WordPress theme</a>, so that I'll have version control and a complete change log for all developmental work on the theme. Another benefit in this is that I can sync the theme easily with my WordPress install, without having to do any FTP uploads (while figuring out which files were changed).

To set up Git repositories on Dream is actually quite easy, and I'll recount how I did it. In the shell code examples below, <strong><em>USER</em></strong> refers to your user name on Dreamhost, while <strong><em>EXAMPLE.COM</em></strong> refers to your domain.

<h3>Step 1: Create A Dreamhost Repository</h3>

Firstly, I created a sub-domain to store my repositories, and I used .htaccess to protect it from the general public.  

Both of these can be done from the Dreamhost Panel by following these two wikis:

1. <a href="http://wiki.dreamhost.com/Subdomain#Adding_A_Subdomain_To_Your_DreamHost_Account">Adding A Subdomain To Your Dreamhost Account</a>
2. <a href="http://blog.dreamhosters.com/kbase/index.cgi?area=801">Configuring .htaccess</a>

Then I entered shell, browsed to the sub-domain which I created in the step above, and created an empty repository with these commands:

[code source="shell"]
$ mkdir my_wp_theme.git
$ cd my_wp_theme.git
$ git --bare init
$ git --bare update-server-info
[/code]

<h3>Step 2: Create A Local Repository</h3>

Next, I created a local repository on my development machine, which will be later published to the Dreamhost repository.

[code source="shell"]
$ mkdir my_wp_theme
$ cd my_wp_theme
$ git init
[/code]

Configure the local repository with the Dreamhost repository details.

[code source="shell"]
$ git config push.default matching
$ git remote add origin ssh://USER@EXAMPLE.COM/home/USER/SUB.EXAMPLE.COM/my_wp_theme.git
$ git config branch.master.remote origin
$ git config branch.master.merge refs/heads/master
[/code]

<h3>Step 3: Push The Contents</h3>

Following which, I copied over my WordPress theme files into this local repository. Then I added, committed and pushed my changes.

[code source="shell"]
$ git add .
$ git commit -m &quot;Initialization.&quot;
$ git push --all
$ git pull
[/code]

<h3>Step 4: Sync With WordPress Install</h3>

To sync with my WordPress install, I browsed to <em>&lt;wordpress&gt;/wp-content/themes</em> and cloned the repository. 

[code source="shell"]
git clone ssh://USER@EXAMPLE.COM/home/USER/SUB.EXAMPLE.COM/my_wp_theme.git
[/code]

Then I went into the WordPress Admin and activated this gitorised theme. Done!

In the future, when I am finished with any changes to my theme, all I have to do is: Push my changes, then pull the changes on the server.
