---
layout: post
title: OpenURI's open, Tempfile and StringIO
---

`OpenURI#open` has a dual personality. Consider the code below..

{% highlight ruby %}
require 'open-uri'

zipfile = open("http://example.com/file.zip")
{% endhighlight %}

With this, `zipfile` can either be a `Tempfile` instance or a `StringIO` instance.

Apparently, that's how `OpenURI#open` works, and this [StackOverFlow post](http://stackoverflow.com/questions/10496874/why-does-openuri-treat-files-under-10kb-in-size-as-stringio) explains it well.
And as mentioned in the same post, to get `OpenURI#open` to always return a `Tempfile`,
apply the initializer "hack".

{% highlight ruby %}
require 'open-uri'

# Don't allow downloaded files to be created as StringIO. Force a tempfile to be created.
OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0
{% endhighlight %}

Or, you can just be deterministic and [create the Tempfile yourself](http://winstonyw.com/2013/10/01/ruby_reading_a_remote_zip_file/).
