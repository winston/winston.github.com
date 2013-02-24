---
layout: post
title: Jekyll, HAML, SASS and GitHub Pages
---

A recap of how I got this Jekyll blog ready..

To start, create a basic Jekyll directory following the instructions on [Jekyll's Wiki](https://github.com/mojombo/jekyll/wiki/usage).

By default, Jekyll only works with HTML and CSS..

To use Jekyll with Haml and Sass, markup converters have to be added.

However, by design, Jekyll doesn't evaluate `layouts` through any Haml converter.
Therefore the converter will only work for `index.haml` that doesn't contain much code.
There are work arounds to ensure that Haml `layouts` will get converted to HTML, but the `layouts` wouldn't get parsed and reloaded for `jekyll --auto --server`.

In the end, my `layouts` are in HTML because the rapid feedback was important to me.

Anyway, to add Haml and Sass converters, create a `_plugins` folder.

Add a Haml converter at `_plugins/haml.rb`.

{% highlight ruby %}
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
{% endhighlight %}

Add a Sass converter `_plugins/sass.rb` and place `.scss` files in `./assets/css`.

{% highlight ruby %}
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
{% endhighlight %}
Everything should work up till this point, and `_site` would contain the generated blog.

However, pushing this directory straight up to GitHub will fail. [Because plugins are evil](https://help.github.com/articles/pages-don-t-build-unable-to-run-jekyll):

> The Pages server will not build with plugins that are not marked as safe.

> Note that this includes all plugins in the _plugins folder.

The deployment becomes slightly complex, and we'll _borrow_ some ideas from [Octopress](http://octopress.org).

Convert the current directory branch from `master` to `source`.

    $> git branch -m master source

Add `_site` to `.gitignore`.

    $> echo '_site' >> .gitignore

Create a deployment directory.

    $> mkdir deploy

Add `deploy` to `.gitignore`.

    $> echo 'deploy' >> .gitignore

Make `deploy` a master branch.

    $> cd deploy
    $> git init .
    $> git commit -am "Initialize"
    $> git remote add origin ...

Add a Rake task that copies `_site` files in `source` branch to `deploy` (master branch).
This Rake task will also commit and push the site to GitHub.

{% highlight ruby %}
desc "Deploy"
task :deploy do
  puts "## Deploying to Github Pages.."

  (Dir["#{deploy_dir}/*"]).each { |f| rm_rf(f) }

  puts "## Copying #{public_dir} to #{deploy_dir}"
  cp_r "#{public_dir}/.", deploy_dir

  cd "#{deploy_dir}" do
    system "git add ."
    system "git add -u"

    puts "## Commiting: Site updated at #{Time.now.utc}"
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m \"#{message}\""

    puts "## Pushing generated #{deploy_dir} website"
    system "git push origin master --force"

    puts "## Deploy Complete!"
  end
end
{% endhighlight %}

Finally, the site can now be deployed to GitHub pages!

One last thing. To get syntax highlighting with Pygments, generate and include the CSS file.

    pygmentize -S default -f html > assets/css/pygments.css

Maybe I should have just used Octopress.
