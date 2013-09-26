---
layout: post
title: GoogleVisualr
---

In 2008, while I was working at Wego.com, I had to build a Google Analytics clone.
The main reason for doing that (versus using Google Analytics)
was because Google Analytics didn't have an API back then.
The data was important to the business as it was used to bill the flight/hotel partners
(on a CPM/CPC/others basis) and so it's crucial that we maintain absolute control over it.

The tool, aptly named Wegonomics, eventually also had the billing functionalities built in.

Anyway, it had a few interesting components:

- A JavaScript tracking script that tracked all of your browsing, searching and clicking activity (partly reverse-engineered from the famous ga.js) to log files.
- A Ruby parser that decoded the log files and dumped meaningful data into a MySQL database.
I also built some fuzzy algorithms to de-dup and de-fraud the searches and clicks because the accuracy of the data affects the P/L of the business.
- A Rails application that presented the data.
It started with tables only but I thought I could do better and started to clone some of the functionalities of Google Analytics in Wegonomics, complete with beautiful charts.

Each component was interesting on its own, and I was pretty proud of my work back then.
Looking back.. Not so much because I left my successor without any tests. Terribly guilty about it.

Anyway, as part of the Rails application that presented data,
I wrote a RubyGem to help with the generation of charts.

This post is really about the charts.
The prelude above is unnecessary other than to serve
as a reminder of how it led to the creation of GoogleVisualr.

To draw the charts, I picked [Google Visualization API]() because it's free and easy to get started with.
It's basically a JavaScript library and you'll write JavaScript to construct the charts.

And generation of the charts is easy and straight forward.
You pick the type of chart, pass data into the chart and draw the chart.

To do that in Rails,
I'll need to pass numbers from the controllers/models to the views as JavaScript constants,
so that the JavaScript in the views can work with the numbers and generate the charts.

That's troublesome.. I want to manipulate the numbers in Ruby, not JavaScript.

Well.. That's why I wrote GoogleVisualr,
so that I can manipulate the numbers and construct the charts in Ruby,
and make it spit out the JavaScript required for the charts.
No need to write JavaScript at all!

Is this considered meta-programming over JavaScript?

Anyway, it works pretty well except that if you need interactions with the charts,
you'll need to write JavaScript for that.

These are the slides which I presented at a Ruby Meetup in 2007.
A little outdated, but it still explains the intention and basics of the RubyGem well.

Check out [GoogleVisualr on GitHub]() or the [Docs]().

Disclaimer:

The stuff about Wego as mentioned in this post is accurate up till 2010.
I am no longer an employee of Wego and I am not sure how much as changed since then.

