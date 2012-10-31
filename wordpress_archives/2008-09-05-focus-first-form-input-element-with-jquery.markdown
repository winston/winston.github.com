--- 
layout: post
title: Focus First Form Input Element with JQuery
wordpress_id: 177
wordpress_url: http://www.winstonyw.com/?p=177
date: 2008-09-05 01:22:59 +08:00
---
A few days ago, I found a JQuery selector that can be used to select the first visible form input element on a page:
[code language="js"]
$(':input:visible:enabled:first')
[/code]
This selector can further be used to focus on the first form input element on page load, as seen in the following code snippet:
[code language="js"]
$(function () {
  $(window).load(function () {
    $(':input:visible:enabled:first').focus();
  });
})
[/code]
In the code snippet above, I placed the focus event call inside the load function (bounded to the window element) so that the focus event fires when the browser finishes loading all content within a document, including window, objects and images. Initially though, I had excluded the load function and had placed the focus event call within only the DOM ready function, but it failed to work.

This simple trick is great for usability, as the user can start filling up a form right away without any additional mouse clicks or key strokes, since the cursor would appear in the first form input element once the page has finished loading.

Google and Yahoo, for example, focus the user's cursor in their search box on page load so that the user can start a search conveniently. In their industry where every search counts towards achieving their business goals, such usability enhancement, though small and subtle, can make a difference.

However, do note that this may only be good for pages that need to focus the user's attention on a form's input field, or for pages whose primary content is a form. Else, it becomes more of an annoyance to find the cursor focused on some obscure form input field on every page load.
