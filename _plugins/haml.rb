# Source: http://blog.martiandesigns.com/2010/07/19/haml-sass-converters-for-jekyll.html

module Jekyll
  require 'haml'
  class HamlConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /haml/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      engine = Haml::Engine.new(content)
      engine.render
      
    rescue StandardError => e
      puts "!!! HAML Error: " + e.message
    end
  end
end
