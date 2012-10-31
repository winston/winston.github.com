--- 
layout: post
title: A Ruby Library For Google Visualization API, GoogleVisualr
wordpress_id: 372
wordpress_url: http://www.winstonyw.com/?p=372
date: 2010-04-16 14:29:35 +08:00
---
In <a href="http://www.wego.com">Wego</a>, we have our own analytics and billing tool that I started building 2 years ago. This tool, in short, observes and logs user behaviour, digitizes and processes the data, then reports it on a Ruby on Rails front-end.

I named the tool aptly, Wegonomics.

Anyway, the very first version of Wegonomics only has numbers in rows and columns, and the metrics displayed were simply just a count of actions grouped by date.

However, I soon realized that a good and useful analytics dashboard is not only about the visual diarrhea of every possible numbers in tables.

What is a good analytics dashboard?

<ul>
  <li>
    A good analytics dashboard provides insight to the numbers.
  </li>  
  <li>
    A good analytics dashboard highlights patterns and trends. 
  </li>  
  <li>
    A good analytics dashboard helps one digests the numbers easily/quickly, and draws brilliant conclusions and  decisions about them.
  </li>  
</ul>

What's essentially missing are charts - visual helpers for the numbers!

My initial search for a great-looking charting tool brought me to <a href="http://teethgrinder.co.uk/open-flash-chart-2/">Open Flash Charts</a>. Indeed, a useful charting tool! However, the Ruby on Rails libraries were disappointing, and it's actually a hassle to integrate OFC into my system.

In the end, I found <a href="http://code.google.com/apis/visualization/http://code.google.com/apis/visualization/http://code.google.com/apis/visualization/interactive_charts.html">Google Visualization API</a>, a Google developed JavaScript library that enables adding of charts into any web page. 

In fact, the API actually powers quite a number of visuaizations in Google Analytics, which means I can recreate a Google Analytics look for my dashboard easily too.

This is the perfect solution for a great-looking and full-featured charting tool! 

However, I need an easier way to integrate Google Visualization API into my system, without having to write data manipulation logic into RoR's views or JavaScript files.

<h3>GoogleVisualr</h3>

Therefore, I created GoogleVisualr - a Ruby library for the Google Visualization API.

<h5>The Gist</h5>

In your model or controller, write Ruby code to create your visualization.

Configure your visualization with any options as listed in Google Visualization API Docs.

In your view, just call a <em>visualization.render(div_id)</em> method and the library will magically generate and insert JavaScript into the final HTML output.

You get your visualization, and you didn't write any JavaScript!

<h5>Limitations</h5>

GoogleVisualr is created solely for the aim of simplifying the display of a visualization, and not the interactions.

Hence, do note that GoogleVisualr is not a 100% complete wrapper for the API.

To be precise, visualization-specific <em>Methods</em> and <em>Events</em> for use after a visualization has been rendered in a View have not been implemented (and may never be?), because they felt more native being written as JavaScript functions, in views/.js files.

<h3>Install</h3>

Clone the GitHub repository into your app/vendor/plugin folder.
[code source="bash"]
&gt; rails my_app 
&gt; cd my_app
&gt; script/plugin install git://github.com/winston/google_visualr.git
[/code]

<h3>Basics</h3>

1. In your Rails layout, load Google Ajax API in the head tag, at the very top.
[code language="html"]
&lt;script src='http://www.google.com/jsapi'&gt;&lt;/script&gt;
[/code]

2. In your Rails controller, initialize a visualization with an empty constructor.
[code language="ror"]
@chart = GoogleVisualr::AreaChart.new
[/code]

3. Populate visualization with column headers, and row values.
[code language="ror"]
# Add Column Headers 
@chart.add_column('string', 'Year' ) 
@chart.add_column('number', 'Sales') 
@chart.add_column('number', 'Expenses') 

# Add Rows and Values 
@chart.add_rows(4) 
@chart.set_value(0, 0, '2004') 
@chart.set_value(0, 1, 1000) 
@chart.set_value(0, 2, 400) 
@chart.set_value(1, 0, '2005') 
@chart.set_value(1, 1, 1170) 
@chart.set_value(1, 2, 460) 
@chart.set_value(2, 0, '2006') 
@chart.set_value(2, 1, 1500) 
@chart.set_value(2, 2, 660) 
@chart.set_value(3, 0, '2007') 
@chart.set_value(3, 1, 1030) 
@chart.set_value(3, 2, 540) 
[/code]

4. Configure visualization with options.
[code language="ror"]
@chart.width  = 400
@chart.height = 240
[/code]

5. In your Rails view, render visualization.
[code language="ror"]
&lt;div id='chart'&gt;&lt;/div&gt;
&lt;%= @chart.render('chart') %&gt;
[/code]

<h3>Documentation and Example</h3>

The above is a basic example of getting started with the GoogleVisualr Ruby library. For more alternatives and examples in instantiating/configuring your visualization, please visit the reference site at <a href="http://googlevisualr.heroku.com">http://googlevisualr.heroku.com</a>.

Current available visualizations are:
<ul>
  <li>Annotated Time Line</li>
  <li>Area Chart</li>
  <li>Bar Chart</li>
  <li>Column Chart</li>
  <li>Gauge</li>
  <li>Spark Line (Image)</li>
  <li>Intensity Map</li>
  <li>Line Chart</li>
  <li>Map</li>
  <li>Motion Chart</li>
  <li>Organizational Chart</li>
  <li>Pie Chart</li>
  <li>Scatter Chart</li>
  <li>Table</li>
</ul>

<h3>Contribution and Support</h3>

The <a href="http://github.com/winston/google_visualr">source of GoogleVisualr is available on GitHub</a>. Go head and clone/fork it!

Please also submit all feedback, bugs and feature-requests to <a href="http://github.com/winston/google_visualr/issues">GitHub Issues Tracker</a>.

<h3>Resources</h3>
 <ul>
  <li><a href="http://code.google.com/apis/visualization/interactive_charts.html">Google Visualization API</a></li>
  <li><a href="http://www.slideshare.net/winstonyw/googlevisualr-3737737">GoogleVisualr Slides</a></li>
</ul>
  
