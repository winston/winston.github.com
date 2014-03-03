---
layout: post
title: GoogleVisualr
---

In 2008, I worked at [Wego.com](http://wego.com) and I had to build a Google Analytics clone from scratch.
The main reason for that was because Google Analytics didn't have an open API back then.
The collected data was important to the P&L as it was used to bill our partners (CPM/CPC)
and so it's crucial that we maintain absolute control over it.

The tool, aptly named Wegonomics, eventually also had the billing functionalities built in.

Anyway, it had a few interesting components:

- A JavaScript tracking script that tracked all of your searching and clicking activities (partly reverse-engineered from the famous ga.js) to log files.
- A Ruby parser that parsed the log files and dumped meaningful data into a database.
I also built some fuzzy algorithms to de-dup and de-fraud the searches and clicks because the accuracy of the data affects the P&L of the business.
- A Rails application that sliced and diced the data for analysis by the management.
The app started with only tables but I gradually added charts to the app so as to create a good analytics dashabord that provided insights to the numbers.

Each component was interesting on its own, and I was pretty proud of my work back then.
Looking back.. Not so, because I left my successor without any tests. *Terribly guilty!*

Anyway, as part of the Rails app,
I wrote a RubyGem to help with the generation of charts,
and this post is really about that - [GoogleVisualr](https://github.com/winston/google_visualr).

To draw the charts, I picked [Google Charts](https://developers.google.com/chart/)
because it's free and easy to get started with.
It's basically a JavaScript library and you'll write JavaScript to draw the charts.

The generation of the charts is pretty easy and straight forward:

- Pick the chart type, e.g. Bar chart, Line chart etc.
- Pass data into the chart
- Draw the chart

That's assuming you already have the data. But where do you usually get the data from?

In any SQL-backed apps, you'll have to retrieve the data from the DB with Ruby/Python etc,
convert the data into JavaScript objects somehow (simplest is to embed it in the views),
and write JavaScript to use the data and generate the chart with it.

Context switching between Ruby and JavaScript is troublesome..

And so, that's how GoogleVisualr came about - a Ruby wrapper around the Google Charts.
Now I can manipulate the numbers and construct the charts in Ruby,
and the RubyGem provides a method to auto-generate the JavaScript required for the charts in the view!

This simplicity works for most use cases, unless you require interactivity with the charts.
Then you'll still need to write JavaScript for that.

A really basic example:

*In your layout, load Google Ajax API in the head tag, at the very top.*

{% highlight html %}
<script src='https://www.google.com/jsapi'></script>
{% endhighlight %}

*In a controller, e.g. `app/controllers/charts_controller.rb`*

{% highlight ruby %}
def area_chart
  data_table = GoogleVisualr::DataTable.new
  # Add Column Headers
  data_table.new_column('string', 'Year' )
  data_table.new_column('number', 'Sales')
  data_table.new_column('number', 'Expenses')

  # Add Rows and Values
  data_table.add_rows([
      ['2004', 1000, 400],
      ['2005', 1170, 460],
      ['2006', 660, 1120],
      ['2007', 1030, 540]
  ])

  option = { width: 400, height: 240, title: 'Company Performance' }
  @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
end
{% endhighlight %}

*In the corresponding view, e.g. `app/views/charts/area_chart.html.erb`*

{% highlight erb %}
<div id='chart'></div>
<%= render_chart(@chart, 'chart') %>
{% endhighlight %}

Go ahead! Check out [GoogleVisualr on GitHub](https://github.com/winston/google_visualr) or the [Docs](http://googlevisualr.herokuapp.com/) now.

These are the slides which I presented at the Singapore Ruby Meetup on 14 Apr 2010.
Definitely outdated, but it still explains the intention and basics of the RubyGem well.

<iframe src="http://www.slideshare.net/slideshow/embed_code/3737737" width="427" height="356" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC;border-width:1px 1px 0;margin-bottom:5px" allowfullscreen> </iframe>
