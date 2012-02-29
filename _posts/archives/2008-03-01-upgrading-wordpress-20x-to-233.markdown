--- 
layout: post
title: Upgrading WordPress 2.0.x to 2.3.3
wordpress_id: 60
wordpress_url: http://www.winstonyw.com/2008/03/01/upgrading-wordpress-20x-to-233/
date: 2008-03-01 20:29:47 +08:00
---
Are you having problems upgrading your WordPress to version 2.3.3?

After following through the extended steps of upgrading WordPress, I encountered the following error on trying to access /wp-admin/upgrade.php:
<blockquote>Internal Server Error

The server encountered an internal error or misconfiguration and was unable to complete your request.

Please contact the server administrator, webmaster@winstonyw.com and inform them of the time the error occurred, and anything you might have done that may have caused the error.

More information about this error may be available in the server error log.</blockquote>
Searching Google and the WordPress forums gave me an answer. Simply add the following two lines to the .htaccess file which should be residing in the blog's root directory:

[source="bash"]
php_value memory_limit 32M
php_flag zend.ze1_compatibility_mode Off
[/source]

Then, I was able to execute /wp-admin/upgrade.php successfully.However, for some reason, WordPress would overwrite .htaccess during the upgrade procedure, and so the two lines would be missing again. I had to add the two lines back to the .htaccess file before my blog is able to work.

Now I am back in business, after forsaking this blog for more than a year!
