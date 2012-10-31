--- 
layout: post
title: "Tweak: Gmail and Reader Integrator"
wordpress_id: 58
wordpress_url: http://www.winstonyw.com/2006/11/07/tweak-gmail-and-reader-integrator/
date: 2006-11-07 00:24:18 +08:00
---
<h3>Editing the Sizes of the Split-Windows</h3>
Suppose you wish to edit the sizes of the split-windows for <a href="http://www.winstonyw.com/2006/11/03/greasemonkey-script-gmail-and-reader-integrator/" target="_blank">Gmail and Reader Integrator</a>, this is possible and easy to accomplish. Follow these steps to customize the Gmail or Reader window sizes to your preference:
<ol>
	<li>In Firefox, open Tools &gt; Greasemonkey &gt; Manage..</li>
	<li>Click on "Gmail + Reader Integrator" in the left panel</li>
	<li>Click "Edit" button</li>
	<li>Choose a text editor, preferably with "Lines Number" display</li>
	<li>Go to Line 54 and 55</li>
	<li>Edit the sizes (in px)</li>
</ol>
<h5>Quick Tip 1:</h5>
In a 1280 x 1024 resolution, the height of an email row in Inbox is approximately 22px. Therefore, the default for "<em>GMAIL_SPLIT_HEIGHT</em>" is set as 220px which displays about 10 email rows in split-window view.

<h3>Editing the Size of the Reader Window (Gmail Collapsed )</h3>
By default, on collapsing the Gmail window while the Reader is open, the Reader would be resized to fill the height of a screen. Suppose you wish to further extend the height of the Reader when the Gmail window is collapsed, do the following:
<ol>
	<li>Search for <em>function resizeReaderFrame</em>, or Line 665</li>
	<li>Change "<em>window.innerHeight - readerEmbed.offsetTop</em>" to a large value</li>
</ol>
<h5>Quick Tip 2:</h5>
You can open|close the Reader window by clicking on the Reader link in the LHS navi. That link is like a "toggle" for the visibility of the Reader window.

Feel free to drop me a message regarding other preferred customizations?

Lastly, the response towards the script has been overwhelming. Thank you!
