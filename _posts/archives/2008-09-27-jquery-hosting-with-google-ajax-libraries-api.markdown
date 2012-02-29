--- 
layout: post
title: jQuery Hosting With Google Ajax Libraries API
wordpress_id: 205
wordpress_url: http://www.winstonyw.com/?p=205
date: 2008-09-27 23:09:18 +08:00
---
<a href="http://code.google.com/apis/ajaxlibs/" target="_blank">Google Ajax Libraries API</a> which hosts a few of the common open source frameworks like jQuery (and UI), Prototype, MooTools and others was launched earlier this year, and I was excited about the performance boost which it promised.

Basically, the libraries are hosted on the Google infrastructure and common obstacles such as caching and gzipping of these Ajax libraries are handled by the Google engineers. The API is also kept up-to-date with the latest stable release of each Ajax library, and by default, serves the minified version. Of course, there's also an option to use an uncompressed version for development purposes.

As my WordPress is on shared hosting, I don't have the luxury of setting up a cache or gzipping my files, and so there's always been a performance issue with my blog. Therefore, any form of optimization could go a long way in making my blog's loading experience more pleasant, and so I figured that the Google Ajax Libraries API should be able to help in some way; moreover, Google has a wide <a href="http://en.wikipedia.org/wiki/Content_Delivery_Network" target="_blank">CDN</a> and their servers are fast.

To use Google's Ajax Libraries API is simple, as illustrated on <a href="http://googleajaxsearchapi.blogspot.com/2008/05/speed-up-access-to-your-favorite.html" target="_blank">Google's Ajax Search API blog</a> and <a href="http://ajaxian.com/archives/announcing-ajax-libraries-api-speed-up-your-ajax-apps-with-googles-infrastructure" target="_blank">Ajaxian</a>, and I made the switch in just 5 minutes for the jQuery framework which I am using on this blog.

Previously, I was including the jQuery packed script which was hosted on my domain, but now I am including the Google's Ajax Libraries API:
[code="html"]
<!-- Previously -->
<!-- <script type="text/javascript" src="js/jquery-1.2.6.pack.js"> -->

<!-- Google's Ajax API -->
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
[/code]

Why was I using the packed version? Because, I cannot do  gzip on my shared hosting and without that, the packed version is smaller in size as compared to the minified version.

In my other external javascript file that contains my jQuery codes, this was how it looked like:
[code="javascript"]
$(function(){
  //Line 1
  //Line 2
  //...
})
[/code]

Now, I need to first load jQuery using the API which has smart versioning feature, then replace jQuery's DOM ready function with Google's on page load function. The internals, or codes, remain the same.
[code="javascript"]
google.load("jquery", "1");
google.setOnLoadCallback(function(){
  //Line 1
  //Line 2
  //...
});
[/code]

That's it! I am done! Testing the response time via YSLOW with Firebug:
<ul>
	<li>jQuery on www.winstonyw.com: Average of 700ms, 31K (No gzip)</li>
	<li>jQuery on Google: Average of 150ms, 16.7K (With gzip)</li>
</ul>

Are you going to make the switch and improve your users' experience?
