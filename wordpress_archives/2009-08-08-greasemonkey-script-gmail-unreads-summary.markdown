--- 
layout: post
title: "Greasemonkey Script: Gmail Unreads Summary"
wordpress_id: 242
wordpress_url: http://www.winstonyw.com/?p=242
date: 2009-08-08 12:33:47 +08:00
---
I am a heavy-user of Gmail and Google Apps, and I spend most of my day in either's web interface. The great thing about using the web interface is that I can either customize it with Gmail's Labs feature, <a href="http://lifehacker.com/software/exclusive-lifehacker-download/better-gmail-2-firefox-extension-for-new-gmail-320618.php">Firefox extensions</a> or <a href="http://www.winstonyw.com/2006/11/03/greasemonkey-script-gmail-and-reader-integrator/">Greasemonkey scripts</a>. Lately, I encountered this problem with my inbox which I felt warranted a scripted solution, and so, I spent a little time to get acquainted with <a href="http://www.greasespot.net/">Greasemonkey</a> again and wrote a simple one.

<strong>First, the problem.</strong>

The thing I dread most with opening my inbox every morning is that it's always flooded with (duh?) emails. The speed at which emails are being sent nowadays is astonishing! After every night, my inbox is usually packed with emails from colleagues, partners, applications (automated notification), newsletters, spam and others. That's a night's worth, so consider my feelings after a long weekend.

Anyway, just for the record, I <strong>LOVE</strong> to adopt a zero-inbox policy, and I archive my emails <strong>VERY, VERY LIBERALLY</strong>, so if my inbox is teeming with 30-40 unread mails, that's considered "full" or "flooded" to me. =)

To tackle the flood, I started with filters and that helped, but I am still not satisfied. Every morning, I'll start the day in my inbox and traverse down the long, long list of unread emails to read, reply, archive or delete. However, at any single point in time, I'll only know the number of unread emails I still have in my inbox, and no further details about these emails. Hmm.. Is there anything that I can do?

<strong>And now, the solution.</strong>

An idea struck me this morning, and I decided to give it a try. After tinkling with <a href="http://wiki.greasespot.net/Greasemonkey_Manual:API">Greasemonkey scripting</a> and <a href="http://code.google.com/p/gmail-greasemonkey/wiki/GmailGreasemonkey10API">Gmail's Greasemonkey API</a> for a while, I present to you: <a href="http://userscripts.org/scripts/show/55245">Gmail Unreads Summary</a>!

<img src="http://www.winstonyw.com/uploads/images/Gmail_Unreads_Summary.jpg" alt="Preview of Gmail Unreads Summary" title="Preview of Gmail Unreads Summary" class="left clear" />

The features of this Greasemonkey script are:
<ul>
	<li>Summary of unread emails in your current view.</li>
	<li>Emails are grouped by sender, with unread count.</li>
	<li>Every group is a quick link to filter emails by sender.</li>
	<li>Easy to use! </li>
</ul>

<a href="http://userscripts.org/scripts/source/55245.user.js" class="download">Download Now!</a>

Anyway, my original intention is to create a summary for ALL the unread emails in your account. However, it's impossible to get all that information from the client-side? Therefore, as a workaround, the summary view is only for the CURRENT VIEW which you are looking at, and the summary changes when you paginates or change views.

Give it a try! Any feedbacks? Would you like to see any other summary details?

Hmm.. I wonder if this is worthy of Gmail Labs..

<strong>Update (20-08-2009)</strong>
I have removed the "Close" functionality and replaced it with a "Toggle" functionality. This is because the "Close" functionality is buggy (as it used a GM value?) when installed as a Firefox extension. Download the script again. Thank you!

<strong>Update (29-08-2009)</strong>
I have made some bug fixes to the script to improve your overall user experience. Firstly, search urls will now make an in-browser refresh and not a full-browser refresh. Secondly. emails with "+" are now searchable too. Download the updated script. Thank you!

<strong>Update (30-08-2009)</strong>
As reported by users, the "minimize" functionality is not sticky after changing views. Therefore I have updated the script to ensure that your preference is remembered. Download the updated script. Thank you!

<strong>Update (11-09-2009)</strong>
This script has been integrated into the <a href="https://addons.mozilla.org/en-US/firefox/addon/6076">Firefox add-on: Better Gmail 2</a> since <a href="http://lifehacker.com/5340034/better-gmail-2-summarizes-unread-messages-by-sender">Aug 18th</a>. Thanks to Gina of Lifehacker! 

<strong>Update (20-09-2009)</strong>
This script has been removed from the Better Gmail 2 extension since version 0.9.4 because I am using a new Greasemonkey function (@require) which is somewhat incompatible with the extension. Please install this as a Greasemonkey script instead.

<strong>Update (26-11-2009)</strong>
The <a href="http://code.google.com/p/gmail-greasemonkey/wiki/GmailGreasemonkey10API">Gmail Greasemonkey API broke</a> (possibly due to changes within Gmail itself), which caused the Greasemonkey script to stop functioning. I have just fixed the bug, so go ahead and <a href="http://userscripts.org/scripts/source/55245.user.js">download the updated version</a>. Thank you!

<strong>Update (16-02-2010)</strong>
The Gmail Greasemonkey API broke again. I have fixed two of the broken functions, but not the third, and so, my script has lost the functionality of "auto-refresh". However, I have added a "Refresh" link, so that refresh can still be done manually. Hopefully this is a good-enough fix for now. Please <a href="http://userscripts.org/scripts/source/55245.user.js">download the updated script</a>. Thank you.

<strong>Update (21-02-2010)</strong>
In this update, I have renamed the "Refresh" link in the last update to "Refresh GMUS" and have shifted its position - putting it just beside Gmail's own "Refresh" view link. <a href="http://userscripts.org/scripts/source/55245.user.js">Download the updated script now.</a> Enjoy!

<strong>Update (21-03-2010)</strong>
I made a minor update to the code and bumped version up to 0.2.1.

AND.. I released a <a href="https://chrome.google.com/extensions/detail/gjcakikdceplkjdcjclidemkcmdbhlkc">Google Chrome extension</a> of the same functionality! Hurray!

<strong>Update (29-03-2010)</strong>
I just pushed an update to UserScripts.org which fixes a few bugs in the last release. In addition, the sender groups are now sorted by count, in descending order.

<a href="http://userscripts.org/scripts/source/55245.user.js">Download</a> the updated script now. Thank you!
