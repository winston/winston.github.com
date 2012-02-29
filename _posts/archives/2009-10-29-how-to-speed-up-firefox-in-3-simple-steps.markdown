--- 
layout: post
title: How To Speed Up Firefox In 3 Simple Steps
wordpress_id: 326
wordpress_url: http://www.winstonyw.com/?p=326
date: 2009-10-29 23:10:35 +08:00
---
Firefox is a great browser and I can't live without it, because of all its useful plugins. However, every so often, Firefox will devour all the memory on my MacBook and become so slow, that I'll be forced to issue a "kill -9" command.

Today, I have had enough, and so decided to go find some Firefox optimization tips that will help to speed up my Firefox. The following are 3 simple steps to make your Firefox fast again, consolidated from sources as listed at the bottom of this post.

Hope you'll find this reference useful, and FYI, my Firefox is amazingly fast again!

<h3>1. Optimize Firefox Database</h3>
<ul>
<li>Menu > Tools > Error Console</li>
<li>Paste the following in the <em>Code</em> box, press "Evaluate", and wait.</li>
</ul>  

[code]
Components.classes[&quot;@mozilla.org/browser/nav-history-service;1&quot;].getService(Components.interfaces.nsPIPlacesDatabase).DBConnection.executeSimpleSQL(&quot;VACUUM&quot;);
[/code]

This vacuums the SQLite database, and is the most significant in speeding up Firefox! Remember to do this periodically.

<h3>2. Limit Your History Sizes</h3>
<ul>
<li>Menu > Preferences (Mac) / Options (Windows) > Privacy Tab</li>
<li>Set "Remember my browsing history for at least ? days" to a small number. Personally, I set mine to 10.</li>
</ul>

As for "Download History", I also unchecked the option, because I have no need for it.

<h3>3. Change Settings in About:Config</h3>
<ul>
<li>Type <em>about:config</em> in your urlbar.</li>
<li>In the <em>Filter</em> box, search for the following names and edit them accordingly.</li>
</ul>

<h5>Browsing and Session Settings</h5>

<em><a href="http://kb.mozillazine.org/Browser.sessionstore.max_windows_undo">browser.sessionstore.max_windows_undo</a></em>
<blockquote>A positive integer indicating how many window closures to remember for later possible restoration. (Default is 3)</blockquote>  
Suggestion: Reduce to 1

<em><a href="http://kb.mozillazine.org/Browser.sessionstore.max_tabs_undo">browser.sessionstore.max_tabs_undo</a></em>
<blockquote>A positive integer indicating how many tab closures to remember for later possible restoration. (Default is 10)</blockquote> 
Suggestion: Reduce to 4

<em>browser.sessionhistory.max_entries</em>
<blockquote>Number of pages stored in the history of your browsing session. Basically these are pages that can be reached using your Back and Forward buttons. (Default is 50)</blockquote>
Suggestion: Reduce to 10

<em><a href="http://kb.mozillazine.org/Browser.urlbar.maxRichResults">browser.urlbar.maxRichResults</a></em>
<blockquote>A non-negative integer corresponding to the maximum number of entries that can appear in the Location Bar auto-complete dropdown. (Default is 12)</blockquote>
Suggestion: Reduce to 6

<em><a href="http://kb.mozillazine.org/Browser.sessionstore.interval">browser.sessionstore.interval</a></em>
<blockquote>A positive integer indicating the number of milliseconds between session saving operations. (Default is 10000, or 10 seconds)</blockquote>
Suggestion: Increase to 150000, or 2.5min

<h5>Networking Settings</h5>

<em><a href="http://kb.mozillazine.org/Network.http.max-connections">network.http.max-connections</a></em>
<blockquote>This integer preference takes values between 1 and 65535 inclusive, directly corresponding to the maximum number of HTTP connections Mozilla can have open at once. (Default is 30).</blockquote> 
Suggestion: Increase to 48 or 96

<em><a href="http://kb.mozillazine.org/Network.http.max-connections-per-server">network.http.max-connections-per-server</a></em>
<blockquote>This preference takes values between 1 and 255 inclusive, directly corresponding to the maximum number of HTTP connections Mozilla can have open at once. (Default is 15)</blockquote> 
Suggestion: Increase to 24  
  
<em><a href="http://kb.mozillazine.org/Network.http.max-persistent-connections-per-server">network.http.max-persistent-connections-per-server</a></em>
<blockquote>This preference takes values between 1 and 255 inclusive, directly corresponding to the maximum number of HTTP keep-alive connections the application can have open at once to a single server. (Default is 6)</blockquote> 
Suggestion: Increase to 12

<em><a href="http://kb.mozillazine.org/Network.http.pipelining">network.http.pipelining</a></em>
<blockquote>Attempt to use pipelining in HTTP 1.1 connections</blockquote>
Suggestion: Change to TRUE

<em><a href="http://kb.mozillazine.org/Network.http.pipelining.maxrequests">network.http.pipelining.maxrequests</a></em>
<blockquote>Any integer from 1 to 8 inclusive determines the maximum number of requests to pipeline at once. A value of 1 disables pipelining. (Default is 4)</blockquote> 
Suggestion: Increase to 8

<h5>Resources</h5>
<ul>
<li><a href="http://mozillalinks.org/wp/2009/08/vacuum-firefox-databases-for-better-performance-now-with-no-restart/">Vacuum Firefox Databases For Better Performance, Now With No Restart</a></li>
<li><a href="http://lifehacker.com/5177260/speed-up-firefox-by-limiting-history-size">Speed Up Firefox By Limiting History Size</a></li>
<li><a href="http://blog.codefront.net/2008/09/10/optimize-firefoxs-memory-usage-by-tweaking-session-preferences/">Optimize Firefox's Memory Usage By Tweaking Session Preferences</a></li>
<li><a href="http://www.makeuseof.com/tag/the-ultimate-guide-to-speeding-up-firefox-3-5/">The Ultimate Guide To Speeding Up Firefox 3.5</a></li>
</ul>
