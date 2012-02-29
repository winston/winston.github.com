--- 
layout: post
title: Installing Ruby Thin Server on Windows
wordpress_id: 62
wordpress_url: http://www.winstonyw.com/2008/03/23/ruby-thin-server-on-windows/
date: 2008-03-23 21:07:26 +08:00
---
For those who are on Windows, but yet wish to install <a href="http://code.macournoyer.com/thin/">Ruby Thin Server</a> on your PC, here's a short how-to.

Ruby Thin Server requires the following dependencies:
<ul>
	<li><a href="http://rack.rubyforge.org/">Rack</a></li>
	<li><a href="http://rubyforge.org/projects/eventmachine/">EventMachine</a></li>
</ul>
Unfortunately, the latest version of EventMachine (0.10.0 at the time of this post) is not a Win32 binary release, so it's a hassle trying to get it installed on Windows. Instead, your best choice would be to download an <a href="http://rubyforge.org/frs/download.php/23665/eventmachine-win32-0.8.1.gem">earlier version of EventMachine 0.8.1</a>, which is a Win32 binary release.

Even though it's an earlier version, I have not encountered any problems with it. Of course, I am using Windows only for development purposes, and not for production purposes.

Install each dependency by following the steps below before you install Thin.
<h3>1. Install Rack.</h3>
[source="sh"]c:\> gem install rack[/source]
<h3>2. Download EventMachine 0.8.1</h3>
<a href="http://rubyforge.org/frs/download.php/23665/eventmachine-win32-0.8.1.gem">Download</a>. Install EventMachine locally.
[source="sh"]c:\> gem install eventmachine -l[/source]
<h3>3. Install Ruby Thin Server, but ignore dependencies.</h3>
[source="sh"]c:\> gem install thin --ignore-dependencies[/source]

Following these steps should install Ruby Thin Server successfully on your Windows machine.

Update from <a href="http://groups.google.com/group/thin-ruby/browse_thread/thread/c15b2472eb97c2ba?hl=en">Google Groups</a>:
Thin has been updated to install EventMachine 0.8.1 if you are on Windows. But you can always rely on the steps above if something fails.
