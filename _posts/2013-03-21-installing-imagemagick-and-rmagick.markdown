---
layout: post
title: Installing ImageMagick and RMagick
---

Specific to Mac OS X 10.7.\*, ImageMagick v6.8.0-10 and RMagick v2.\*.

The correct way to do it:

    $ brew remove imagemagick
    $ brew install imagemagick --disable-openmp --build-from-source

    $ cd /usr/local/Cellar/imagemagick/6.8.0-10/lib
    $ ln -s libMagick++-Q16.7.dylib   libMagick++.dylib
    $ ln -s libMagickCore-Q16.7.dylib libMagickCore.dylib
    $ ln -s libMagickWand-Q16.7.dylib libMagickWand.dylib

The errors I got when I didn't install ImageMagick with the config options:

    It seems your ruby installation is missing psych (for YAML output).
    To eliminate this warning, please install libyaml and reinstall your ruby.
    Building native extensions.  This could take a while...
    ERROR:  Error installing rmagick:
    	ERROR: Failed to build gem native extension.

            /Users/winston/.rvm/rubies/ruby-1.9.3-p392/bin/ruby extconf.rb
    checking for Ruby version >= 1.8.5... yes
    extconf.rb:107: Use RbConfig instead of obsolete and deprecated Config.
    checking for /usr/bin/gcc-4.2... yes
    checking for Magick-config... yes
    checking for ImageMagick version >= 6.3.5... yes
    checking for HDRI disabled version of ImageMagick... yes
    /usr/local/bin/Magick-config: line 41: pkg-config: command not found
    /usr/local/bin/Magick-config: line 47: pkg-config: command not found
    /usr/local/bin/Magick-config: line 50: pkg-config: command not found
    /usr/local/bin/Magick-config: line 53: pkg-config: command not found

The errors I got when I didn't do the symlinks:

    It seems your ruby installation is missing psych (for YAML output).
    To eliminate this warning, please install libyaml and reinstall your ruby.
    Building native extensions.  This could take a while...
    ERROR:  Error installing rmagick:
    	ERROR: Failed to build gem native extension.

            /Users/winston/.rvm/rubies/ruby-1.9.3-p392/bin/ruby extconf.rb
    checking for Ruby version >= 1.8.5... yes
    extconf.rb:107: Use RbConfig instead of obsolete and deprecated Config.
    checking for /usr/bin/gcc-4.2... yes
    checking for Magick-config... yes
    checking for ImageMagick version >= 6.3.5... yes
    checking for HDRI disabled version of ImageMagick... yes
    checking for stdint.h... yes
    checking for sys/types.h... yes
    checking for wand/MagickWand.h... yes
    checking for InitializeMagick() in -lMagickCore... no
    checking for InitializeMagick() in -lMagick... no
    Can't install RMagick 2.12.2. Can't find the ImageMagick library or one of the dependent libraries. Check the mkmf.log file for more detailed information.

And seriously, you might want to consider the [MiniMagick](http://rubygems.org/gems/mini_magick) gem instead.
