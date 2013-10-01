---
layout: post
title: Ruby - Reading A Remote Zip File
---

I need to access the contents of a remote zip file.

Do you have the same use case? This is something that works:

    require "httparty"  # HTTParty Gem
    require "zip"       # RubyZip Gem

    zipfile = Tempfile.new("file")
    zipfile.binmode # This might not be necessary depending on the zip file
    zipfile.write(HTTParty.get("http://localhost:3000/file.zip").body)
    zipfile.close

    Zip::File.open(zipfile.path) do |file|
      file.each do |content|
        data = file.read(content)
        puts data
        # Do whatever you want with the contents
      end
    end

Basically, this is what the code above is doing (in memory):

 - Get the contents of the remote zip file and write into a temp zip file
 - Unzip the temp zip file
 - Do whatever I want with the contents
 - Let garbage collection delete the temp zip file

Anyway, before I used HTTParty, I was trying to use `open` of OpenURI but it was terrible.

So `OpenURI#open` would either give me a `Tempfile` instance or a `StringIO` instance when I use it in this way:

    require 'open-uri'

    zipfile = open("http://example.com/file.zip")

Apparently, that's how `OpenURI#open` works, and [StackOverFlow](http://stackoverflow.com/questions/10496874/why-does-openuri-treat-files-under-10kb-in-size-as-stringio) explains it brilliantly. However, I didn't really want to deal with the ambiguity.

And even with the initializer "hack" as mentioned in the StackOverFlow post..

    require 'open-uri'

    # Don't allow downloaded files to be created as StringIO. Force a tempfile to be created.
    OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
    OpenURI::Buffer.const_set 'StringMax', 0

.. I didn't get a Tempfile instance deterministically in my specs and rake tasks etc.

So for now, I'll party hard with HTTParty.
