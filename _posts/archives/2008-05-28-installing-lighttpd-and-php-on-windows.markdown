--- 
layout: post
title: Installing LightTPD and PHP on Windows
wordpress_id: 64
wordpress_url: http://www.winstonyw.com/2008/05/28/installing-lighttpd-and-php-on-windows/
date: 2008-05-28 22:53:27 +08:00
---
This blog is in need of a makeover, and so I am trying to keep the procrastination habit at bay, practice some GTD and get started on creating a new template for it. First of all, I need a local development environment for PHP on Windows, since I am a Windows user. Previously, I would have installed <a href="http://sg.php.net/install.windows" target="_blank">IIS on Windows and used it as the server for PHP</a>, but it's always a chore trying to find my Windows CD.

Fortunately, I learnt about <a href="http://www.lighttpd.net/" target="_blank">LightTPD</a> recently in my work at <a href="http://www.wego.com" target="_blank">Wego</a> and how I can use it to replace IIS as the server for PHP. It's easy installation and setup within minutes. Great! Let's get started!

<h3>1. Download and Install PHP</h3>
Download PHP from <a href="http://www.php.net/downloads.php">PHP website</a>. I chose the zip package and simply unzipped it into my directory of choice: Almighty C drive! So now, it's residing at "C:\php".

<h3>2. Download and Install LightTPD</h3>
Download a Win32 version of LightTPD from the <a href="http://en.wlmp-project.net/downloads.php?cat=lighty" target="_blank">WLMP Project</a>; I chose the Setup Wizard (.exe) version.

Double-click on the downloaded executable to start the short installation process, during which you would specify the destination of the install. I installed mine at "C:\Program Files\LightTPD".

<h3>3. Start and Test LightTPD</h3>
To start LightTPD, go to the LightTPD directory (i.e. "C:\Program Files\LightTPD"), find the file "TestMode.bat" and double-click on it. A console window would open and indicate that the server has been started.

To test that LightTPD is working at this moment, point your browser to http://localhost. You should see a "LightTPD Test Page".

That was easy right? Now we just need to edit some configurations to make PHP work with LightTPD.

<h3>4. Editing LightTPD Configurations</h3>
Edit the file lighttpd-inc.conf (i.e. "C:\Program Files\LightTPD\conf\lighttpd-inc.conf") with the following:
<ul>
	<li>Remove the comment tag for "mod-cgi" (Line 20)</li>
	<li>Add this line (assuming that PHP was installed on C drive):
<ul>
	<li>cgi.assign = ( ".php" =&gt; "C:/php/php-cgi.exe" )</li>
</ul>
</li>
</ul>
<h3>5. Editing PHP Configurations</h3>
In your PHP directory, rename the file php.ini-recommended to php.ini and edit php.ini with the following:
<ul>
	<li>  short_open_tag = On</li>
	<li>  display_errors = On</li>
	<li>  doc_root = "C:\Progra~1\LightTPD\htdocs"</li>
</ul>
<h3>6. Test PHP with LightTPD</h3>
To test that LightTPD now works with PHP, create a file with the following contents:
[source="php"]
<?php phpinfo(); ?>
[/source]

Place the file in your htdocs directory (i.e. "C:\Program Files\LightTPD\htdocs"), open up your browser and browse to the page. Walaa! You should be able to see the standard phpinfo() messages.

There you have it! A development environment for PHP on Windows in 6 simple steps. Now, to get started on the new template..
