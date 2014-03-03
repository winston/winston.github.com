---
layout: post
title: Time.now vs Time.zone.now
---

Ruby `Time` can get confusing when used in your Rails app. What `Time` is it now?

Suppose I have a server in UTC time and all of my users are from Singapore (GMT +08:00),
then your Rails app's `time_zone` should be configured to SGT.

{% highlight ruby %}
# config/application.rb

# Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
# Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
config.time_zone = 'Singapore'
{% endhighlight %}

Besides that, instead of using `Time.now`, use `Time.zone.now` especially when
you are printing time attributes as display to your users.

Why? Let's explore the difference:

{% highlight ruby %}
irb> Time.zone = "Singapore"
=> "Singapore"
irb> Time.now
=> 2014-03-03 11:07:05 +0000
irb> Time.zone.now
=> Mon, 03 Mar 2014 19:07:12 SGT +08:00
{% endhighlight %}

`Time.now` uses the system time because it's is part of the Ruby standard library.

However, `Time.zone.now` returns the time, corrected to our Singapore time zone
because it's been [extended by ActiveSupport](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/time/zones.rb#L11) to have the `zone` method.

Therefore, in order for your users to see the time in SGT, use `Time.zone.now` in your code. In fact, use `Time.current`. [Read the code](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/time/calculations.rb#L29) to find out what's the difference.

What about `DateTime`?

{% highlight ruby %}
irb> Time.zone = "Singapore"
=> "Singapore"
irb> DateTime.now
=> Mon, 03 Mar 2014 11:15:08 +0000
irb> DateTime.now.in_time_zone
=> Mon, 03 Mar 2014 19:15:14 SGT +08:00
{% endhighlight %}

`DateTime` returns the system time too because it's also part of the Ruby standard library.

The method to convert `DateTime` to our time zone is the `.in_time_zone` method which [also accepts a time zone as a param](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/date_and_time/zones.rb#L19).

Now then.. What do you do when you query the database with ActiveRecord?

You can use either `Time.now` or `Time.current`.
Both will work because ActiveRecord will convert the times to UTC before sending it to the database,
as all time columns in the database are also stored in UTC. Let's verify..

{% highlight ruby %}
irb> Feedback.all
  Feedback Load (0.4ms)  SELECT "feedbacks".* FROM "feedbacks"
=> [#<Feedback id: 1, created_at: "2014-03-03 11:29:26", updated_at: "2014-03-03 11:29:26">]
{% endhighlight %}

Notice that `created_at` and `updated_at` columns are stored in UTC.

{% highlight ruby %}
irb> Feedback.first.created_at
  Feedback Load (0.4ms)  SELECT "feedbacks".* FROM "feedbacks" ORDER BY "feedbacks"."id" ASC LIMIT 1
=> Mon, 03 Mar 2014 19:29:26 SGT +08:00
{% endhighlight %}

When you retrieve an object and print `created_at`, it will be converted to your time zone.

{% highlight ruby %}
irb> Time.now
=> 2014-03-03 11:41:31 +0000
irb> Feedback.where("created_at < ?", Time.now)
  Feedback Load (0.5ms)  SELECT "feedbacks".* FROM "feedbacks" WHERE (created_at < '2014-03-03 11:41:32.687457')
=> [#<Feedback id: 1, created_at: "2014-03-03 11:29:26", updated_at: "2014-03-03 11:29:26">]
{% endhighlight %}

When you use `Time.now`, it generates a SQL query with time in UTC.

{% highlight ruby %}
irb> Time.current
=> Mon, 03 Mar 2014 19:42:22 SGT +08:00
irb> Feedback.where("created_at < ?", Time.current)
  Feedback Load (0.4ms)  SELECT "feedbacks".* FROM "feedbacks" WHERE (created_at < '2014-03-03 11:42:23.549020')
=> [#<Feedback id: 1, created_at: "2014-03-03 11:29:26", updated_at: "2014-03-03 11:29:26">]
{% endhighlight %}

When you use `Time.current`, it also generates a SQL query with time in UTC.

Hope this helps to explain `Time` in Rails!

Further reading:

- [Working with time zones in Ruby on Rails](http://www.elabs.se/blog/36-working-with-time-zones-in-ruby-on-rails)
- [The Exhaustive Guide to Rails Time Zones](http://danilenko.org/2012/7/6/rails_timezones/)
