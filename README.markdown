MongoidShortener
================

MongoidShortener is a gem that has to be used together with Mongoid to
shorten URLs. It uses the [yab62][1] gem to convert URLs to base 62
shortened link.

It is based on Rails engine. I have only tested this on Rails 3.1. You
might have problem using with Rails version less than 3.1.

To use MongoidShortener, first you have to install the gem.

```ruby
# Gemfile
gem "mongoid_shortener"
# Terminal
bundle install
```

After that, make sure that you have set the `MongoidShortener`'s
`root_url` and `prefix_url`, you can do this like the following:

```ruby
# /config/initializers/mongoid_shortener.rb
MongoidShortener.root_url = "http://dailymus.es"
MongoidShortener.prefix_url = "http://dailymus.es/~"
```

`root_url` is the url that gets redirected to if no matched shortened
url is found.

`prefix_url` is the url get prefixed to the unique_key after the base 62
conversion. For example, if the link `http://google.com` gets converted
to `xYAwc`. The returned link will be `http://dailymus.es/~xYAwc` for
the above example code.

To use MongoidShortener in your project, it provides you with two simple
helper functions. One is for internal use and another one is the view
helper.

```ruby
MongoidShortener.root_url = "http://dailymus.es"
MongoidShortener.prefix_url = "http://dailymus.es/~"

# helper function
MongoidShortener.generate("http://google.com") # -> "http://dailymus.es/~xYAwc"

# view helper function
shortened_url("http://google.com") # -> "http://dailymus.es/~xYAwc"
```

Besides that, MongoidShortener also provides a really good helper controllor that
you can make use of. To use it, add this particular route to your
`config/routes.rb`

```ruby
# config/routes.rb
match '/:unique_key' => 'mongoid_shortener/shortened_urls#translate', :via => :get, :constraints => { :unique_key => "~.+" }
```

What this basically does is that it creates a routes that will only
match anything starts with `/~`. So, when theres is a request that hits
that route, it will get redirect to the helper controller of
MongoidShortener.

The controller code in fact looks like:

```ruby
module MongoidShortener
  class ShortenedUrlsController < ApplicationController
    # find the real link for the shortened link key and redirect
    def translate
      # pull the link out of the db
      sl = ShortenedUrl.where(:unique_key => params[:unique_key][1..-1]).first

      if sl
        sl.inc(:use_count, 1)
        # do a 301 redirect to the destination url
        head :moved_permanently, :location => sl.url
      else
        # if we don't find the shortened link, redirect to the root
        # make this configurable in future versions
        head :moved_permanently, :location => MongoidShortener.root_url
      end
    end
  end
end
```

Let me know if you find any bug for this particular plugin.

LICENSE
=======

(The MIT License)

Copyright (c) 2011 Teng Siong Ong

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[1]: https://github.com/siong1987/yab62
