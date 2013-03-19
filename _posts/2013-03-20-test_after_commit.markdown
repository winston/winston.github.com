---
layout: post
title: Test After Commit
---

Sometimes, you will need to test the `after_commit` call back in Rails. Really.

Such as when you are using [Devise](https://github.com/plataformatec/devise), and you want to send your emails asynchronously through [Devise's recommendation](https://github.com/plataformatec/devise/blob/master/lib/devise/models/authenticatable.rb#L130).

Assuming that you are also using RSpec and transactional fixtures, then [test_after_commit](https://github.com/grosser/test_after_commit) is what you will need.

The RubyGem works as expected and `bundle install` is eaaaaasy.
