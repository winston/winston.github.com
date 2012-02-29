--- 
layout: post
title: Search by Date or Timestamp in MySQL
wordpress_id: 61
wordpress_url: http://www.winstonyw.com/2008/03/17/search-by-date-or-timestamp-in-mysql/
date: 2008-03-17 23:26:28 +08:00
---
Lately, I have been very much involved in web development especially with MySQL, and searching by date or timestamp on a very large set of data is by far the most common task that I am required to do. Due to this, I was able to refresh my knowledge on MySQL and able to pick up some tips and tricks on working with date or timestamp in MySQL.

One of the <a href="http://dev.mysql.com/doc/refman/5.0/en/comparison-operators.html">helpful functions</a> I found, was <em>BETWEEN..AND...</em> Previously, if I was extracting data between two dates, e.g. all records that occurred in the month of January, I would code my query like this:

[source language="sql"]
select * from table_name
where created_at &gt;= &quot;2008-01-01&quot; and created_at &lt;= &quot;2008-02-01;
[/source]

However, the "greater than" and "lesser than" comparison can actually be replaced by a single function, <em>BETWEEN..AND..</em>:

[source language="sql"]
select * from table_name
where created_at between &quot;2008-01-01&quot; and &quot;2008-02-01;
[/source]

Do note that the first date to be specified in the query MUST be earlier than the second date, else the query would simply return an empty set. Hope you won't repeat the same mistake as I did.. I had to spend like 15 minutes looking at the query before I discovered the gruesome error.

In addition, if you look at the documentation, it states that:
<blockquote> 
If expr is greater than or equal to min and expr is less than or equal to max, BETWEEN returns 1, otherwise it returns 0. This is equivalent to the expression (min <= expr AND expr <= max) if all the arguments are of the same type.
</blockquote>

Why then did I use <em>"between '2008-01-01' and '2008-02-01'"</em> to extract all information that occurred within the month of January, and not <em>"between '2008-01-01' and '2008-01-31'"</em>?

This is because, if the timestamp is not stated (i.e. only a date is used), MySQL automatically assumes a timestamp of <em>00:00:00</em> for the date. Hence, if I had used <em>"between '2008-01-01' and '2008-01-31'"</em>, MySQL would have changed that to <em>"between '2008-01-01 00:00:00' and '2008-01-31 00:00:00'"</em>, which clearly indicates that any record with a date of <em>2008-01-31</em> and timestamp greater than <em>00:00:00</em> would be excluded from the query. This is different from what we want, which is all the records in the month of January, 31st January inclusive.

Try this to verify that MySQL sets a timestamp of <em>00:00:00</em> for a date:

[source language="sql"]
mysql&gt; select current_date();

+----------------+
| current_date() |
+----------------+
| 2008-03-17     |
+----------------+
1 row in set (0.00 sec)

mysql&gt; select timestamp(current_date());

+---------------------------+
| timestamp(current_date()) |
+---------------------------+
| 2008-03-17 00:00:00       |
+---------------------------+
1 row in set (0.00 sec)
[/source]

Hopefully, this post has helped you to better understand how to use <em>BETWEEN..AND..</em> to query your databases. In my subsequent posts, I will look at other useful MySQL functions.
