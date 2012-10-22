# http://mikeferrier.com/2011/04/29/blogging-with-jekyll-haml-sass-and-jammit/

module Jekyll
  require 'sass'
  class SassConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /scss/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      engine = Sass::Engine.new(content, :syntax => :scss, :load_paths => ["./assets/css/"])
      engine.render
    rescue StandardError => e
      puts "!!! SASS Error: " + e.message
    end
  end
end
