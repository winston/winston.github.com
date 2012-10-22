# http://mikeferrier.com/2011/04/29/blogging-with-jekyll-haml-sass-and-jammit/

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
