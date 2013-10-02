---
layout: post
title: Ruby - Reading A Remote Zip File
---

I need to access a remote zip file and this is something that works:

    # In the console, gem install "httparty"
    require "httparty"

    # In the console, gem install "rubyzip"
    require "zip"

    # Get the contents of the remote zip file via HTTParty
    # and write it into a temp zip file

    zipfile = Tempfile.new("file")
    zipfile.binmode # This might not be necessary depending on the zip file
    zipfile.write(HTTParty.get("http://localhost:3000/file.zip").body)
    zipfile.close

    # Unzip the temp zip file and process the contents
    # Let garbage collection delete the temp zip file

    Zip::File.open(zipfile.path) do |file|
      file.each do |content|
        data = file.read(content)
        puts data
        # Do whatever you want with the contents
      end
    end

The code is simple, but at the start, I kept getting an error when unzipping the temp zip file,
and I thought I was doing something wrong.

    End-of-central-directory signature not found

Did some debugging and finally figured out that the problem was with the remote zip file
- because the file was not fully constructed even though I had a link to it.

The remote zip file link was actually returned by an earlier API call to an external service
that also triggered the building of the remote zip file.

Moral of the story? Trust my code.

Anyway, [RubyZip is poor in performance](http://blog.huangzhimin.com/2012/10/02/avoid-using-rubyzip/). Might want to try [ZipRuby](http://zipruby.rubyforge.org/) instead.
