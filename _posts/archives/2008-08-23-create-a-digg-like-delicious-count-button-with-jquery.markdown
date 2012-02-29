--- 
layout: post
title: Create a Digg-Like Delicious Count Button With JQuery
wordpress_id: 161
wordpress_url: http://www.winstonyw.com/?p=161
date: 2008-08-23 23:57:22 +08:00
---
<h3>Background</h3>
During the conceptualization stages of Winston{YW}, I was inspired by <a href="http://woork.blogspot.com" target="_blank">Antonio</a> and so, I wanted my WordPress blog to have a Delicious Count Button on each post too. Ideally, this Delicious Count Button could be used to bookmark the post in <a href="http://www.delicious.com" target="_blank">Delicious</a>, and at the same time, display the number of times the post has been bookmarked on Delicious.

By referring to the <a href="http://delicious.com/help/feeds" target="_blank">new Delicious API</a>, I managed to build this Delicious Count Button with JQuery, and I even styled it to match the looks of the <a href="http://digg.com/tools/integrate" target="_blank">Digg button</a>. Now, I shall go through the process of building this Delicious Count Button for your WordPress blog. See a <a href="http://www.winstonyw.com/wp-demo/create-a-digg-like-delicious-count-button-with-jquery-demo.html" target="_blank">DEMO here</a>.
<h3>Step 1: The Button Image</h3>
Browse to the <a href="http://digg.com/img/digg-it-tiny-submit.gif" target="_blank">image on Digg's website</a>. "Right Click" the image, and "Save Image As". Place the image in your theme's IMAGES directory.
<h3>Step 2: The HTML</h3>
You should be familiar with <a href="http://codex.wordpress.org/The_Loop" target="_blank">The Loop in WordPress</a>. Copy this snippet of HTML into The Loop; place it where you would like to have this Delicious Count Button.
[code language="php"]
&lt;div class='post_delicious'&gt;
  &lt;span class='md5hash'&gt;&lt;?php echo md5(get_permalink()); ?&gt;&lt;/span&gt;
  &lt;a href='http://del.icio.us/post?v=4&amp;amp;noui&amp;amp;jump=close&amp;amp;url=&lt;?php the_permalink() ?&gt;&amp;amp;title=&lt;?php echo urlencode(the_title('','',FALSE)) ?&gt;' target='_blank'&gt;Del.icio.us&lt;/a&gt;
&lt;/div&gt;
[/code]
This snippet of code sets up a DIV that contains a SPAN and an ANCHOR. The SPAN is where the magic occurs as the content would be replaced by a count of the number of times your post has been bookmarked on Delicious through the use of JQuery. The content in the SPAN tag is actually a MD5 hash of the permalink of the post, which is used as an unique key to query the Delicious API for details of this post. The ANCHOR is a link which contains the necessary parameters, populated by the details of each post, to submit the post to Delicious.
<h3>Step 3: The CSS</h3>
Copy this snippet of CSS into the CSS file, which should be styles.css for most WordPress themes. This would style the DIV which you copied in Step 2, and make it look like the Digg button.
[code language="css"]
.post_delicious {
  display: block;
  background: url('images/tiny-submit.gif') no-repeat top right;
  height: 20px;
  width: 85px;
  padding: 2px 45px 0px 0;
  font-family: arial, sans-serif;
  font-size: 11px;
  font-weight: bold;
  cursor: pointer;
}

.md5hash {
  display: none;
}

.post_delicious a, .post_delicious a:visited {
  float: right;
  color: #444444;
  text-decoration: none;
}

.post_delicious a:hover {
  color: #0000000;
  text-decoration: underline;
}
[/code]
<h3>Step 4: The JQuery Package</h3>
Proceed to download the <a href="http://docs.jquery.com/Release:jQuery_1.2.6" target="_blank">latest version of JQuery</a>, or use a Google-hosted version of JQuery by reading more about it on the <a href="http://code.google.com/apis/ajaxlibs/" target="_blank">Google AJAX Libraries API</a>. Insert the link to the JQuery package in the HEAD tags of your HTML.
[code language="php"]
&lt;head&gt;
  &lt;!-- Misc Stuff --&gt;
  &lt;script type='text/javascript' src='&lt;directory_to&gt;/jquery-1.2.6.pack.js'&gt;&lt;/script&gt;
&lt;/head&gt;
[/code]
<h3>Step 5: The JQuery Code</h3>
Copy this snippet of JQuery code. Place it either in the HEAD tags of your HTML, or at the bottom of your HTML, just before the closing HTML tag.
[code language="javascript"]
&lt;script type='text/javascript'&gt;
  $(function() {
  
    $.each($('span.md5hash'), function () {
      var elem = $(this);
      $.ajax({ type:      'GET',
               dataType:  'jsonp',
               url:       'http://feeds.delicious.com/v2/json/urlinfo/'+$(this).html(),
               success:   function(data){
                            if (data.length &gt; 0) {
                              elem.next().prepend(data[0].total_posts + ' ');
                            }
                          }
            });
    });
  
  })
&lt;/script&gt;
&lt;/script&gt;
[/code]
This is the MAGIC! Once your blog is loaded in a browser, this snippet of code scans for all the SPAN tags that has the class "md5hash", and for each SPAN tag found (which should be one per post), it issues an AJAX request to the new Delicious API to obtain details of the post.

On the return of the AJAX request, the content in the SPAN tag (which is the MD5 hash of the permalink) is then replaced with a count of the number of times the post has been bookmarked on Delicious.
<h3>Conclusion</h3>
Finally, upload your changes and with that, you have successfully placed a Delicious Count Button on each of your posts! I hope you find this post useful, and do let me know in the comments if you have any questions or encounter any problems.
