---
layout: post
title: Form With Multiple Buttons
---

Suppose you have a form and you need to have two buttons that post to different locations -
button "Accept" posts to `/accept` and button "Reject" posts to `/reject`.

Without HTML5, you probably have to use JavaScript..

HTML5 makes it trivial, as it introduced the [concept of *_form_* and *_form-associated element_*](http://www.w3.org/html/wg/drafts/html/master/forms.html#attr-fae-form).

By default, the form owner of a submit `input` is the nearest `form` element ancestor,
and it would perform the action and go to the location that was specified in the `form` tag.

However, HTML5 allows you to specify `form` attribute (and more) on an `input` tag to override its default `form` association.

In code, that means you can do the following:

{% highlight html %}
<form id="myform">
  <input id="name" name="name" type="text">
</form>

<input type="submit" value="Accept" form="myform" formmethod="POST" formaction="/accept">
<input type="submit" value="Reject" form="myform" formmethod="POST" formaction="/reject">
{% endhighlight %}

Side note.. To test this in Rspec + Capybara, specs have to run with a JavaScript driver.

I really dig this.
