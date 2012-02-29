--- 
layout: post
title: Allowing Intuitive Date Range Input With Date()
wordpress_id: 63
wordpress_url: http://www.winstonyw.com/2008/04/09/allowing-intuitive-date-range-input-with-date/
date: 2008-04-09 23:58:50 +08:00
---
For my current project, a small part of it requires that a web form be built that would request for a date range input from the user. On submit, the form would send a select statement, together with the date range input as a condition, to the underlying database, retrieve a set of results and display it. For this purpose, naturally I am using the <em>BETWEEN .. AND</em> function <a href="http://www.winstonyw.com/2008/03/17/search-by-date-or-timestamp-in-mysql/">as discussed previously</a>.

Recall that if you would like to return results for the month of March, you would need to have a condition like:
[source="sql"]
WHERE created_at BETWEEN "2008-03-01" AND "2008-04-01"
[/source]
in which created_at is a datetime value.

However, the date range "2008-03-01" to "2008-04-01" is not a practical input to the web form. Intuitively, if this date range were to be entered as a form input, the user would have intended that the form returned all results between March 1st to April 1st <strong>inclusive</strong>. Instead, to return only the results between March 1st and March 31st, a more intuitive input would have been "2008-03-01" to "2008-03-31".

Then how can we allow the user to key in a set of intuitive inputs (but erroneous when fed directly to the database), and at the same time return a set of correct results? To overcome this, we have two solutions:

<h3>First Solution</h3>
Programatically, increase the latter date by a day before constructing your <em>WHERE</em> clause in your select query. For example, we modify "2008-03-31" to become "2008-04-01" before issuing the select query to the database.

However, this is not an elegant solution as extraneous code is required to massage the input in order to yield the correct set of results.

<h3>Second (and Better) Solution</h3>
Use the <a href="http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html#function_date">DATE() function</a> to extract the date part of the datetime value, created_at, in the WHERE conditional clause:
[source="sql"]
WHERE DATE(created_at) BETWEEN "2008-03-01" AND "2008-03-31"
[/source]
In this case, you are effectively only comparing the date part of the created_at value to the date range, and timestamp is completely omitted from the comparison.

Simple, intuitive, and yields the expected set of results.
