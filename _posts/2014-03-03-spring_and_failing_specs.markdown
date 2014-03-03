---
layout: post
title: Spring And Failing Specs
---

[Spring](https://github.com/rails/spring) will be [included in Rails 4.1](http://edgeguides.rubyonrails.org/4_1_release_notes.html) as the defacto Application Preloader.
It's similar to [Zeus](https://github.com/burke/zeus) which keeps your application running in the background during development,
so that any rake or spec command will run speedily without having to reload the app.

Anyway, I was using `spring`, `spring-commands-rspec` and `enumerize` gems in my app
and was running specs with `spring rspec` when this happened:

    $> spring rspec

    ........F.............................

    Failures:

      1) Feedback validations
         Failure/Error: it { should enumerize(:emotion).in(:happy, :sad) }
         NoMethodError:
           undefined method `enumerize' for #<RSpec::Core::ExampleGroup::Nested_3::Nested_2:0x000001029bcd20>
         # ./spec/models/feedback_spec.rb:22:in `block (3 levels) in <top (required)>'
         # -e:1:in `<main>'

    Finished in 0.27399 seconds
    38 examples, 1 failure

However, if I just do `rspec`, the specs passed!

    $> rspec

    ......................................

    Finished in 0.27061 seconds
    38 examples, 0 failures

    Randomized with seed 2852

Dug into the problem and found that this was a loading issue with `enumerize`.

This was how the `enumerize` matchers were loaded:

{% highlight ruby %}
if defined?(::RSpec)
  require 'enumerize/integrations/rspec'
end
{% endhighlight %}

And it works fine for plain `rspec` command because `rspec` loads before `rails`.
However, when `spring` starts the application, `rspec` is not yet loaded and so
the matchers will not be required as well.

The fix is to load `rspec` like this:

{% highlight ruby %}
begin
  require 'rspec/matchers'
rescue LoadError
else
  require 'enumerize/integrations/rspec'
end
{% endhighlight %}

This makes sure that the `enumerize` matchers will only required when `rspec/matchers` can be required without errors,
which means it will only load in dev or test environment because you shouldn't have `rspec` bundled in your production environment.

[Pull request over here](https://github.com/brainspec/enumerize/pull/143).

Keep this in mind when you encounter weird failing specs when using `spring`.
