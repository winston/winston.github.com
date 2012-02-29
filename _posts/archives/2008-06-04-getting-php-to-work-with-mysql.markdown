--- 
layout: post
title: Getting PHP to work with MySQL
wordpress_id: 65
wordpress_url: http://www.winstonyw.com/2008/06/04/getting-lighttpd-to-work-with-mysql/
date: 2008-06-04 22:11:24 +08:00
---
In my <a href="http://www.winstonyw.com/2008/05/28/installing-lighttpd-and-php-on-windows/" target="_blank">previous post</a>, I described how to get PHP working with LightTPD on a Windows machine. But that's not the end of the story, since what I really wanted was to get my local WordPress installation working, and the missing piece to the puzzle is to make sure that PHP is enabled for MySQL use.

To do that, simply edit the following in the php.ini file:
<ul>
	<li>Load MySQL extensions from the correct directory: extension_dir = "c:\php\ext"</li>
	<li>Remove the comment tag for: extension=php_mysql.dl"</li>
</ul>
A simple post that's really supposed to be appended to the previous post, but I had some problems trying to get the get the code tag working, so I prefer not to touch that post again.

Anyway, my WordPress is in the htdocs directory right now, waiting for me to start some serious templating.
