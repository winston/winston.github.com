# Source: http://blog.martiandesigns.com/2010/07/19/haml-sass-converters-for-jekyll.html

module Jekyll
  require 'sass'
  class SassConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /sass/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      engine = Sass::Engine.new(content)
      engine.render
      
    rescue StandardError => e
      puts "!!! SASS Error: " + e.message
    end
  end
end
