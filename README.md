# Twitter::Bootstrap::Rails::Confirm

This gem adds some javascript to change the default behaviour of data-confirm processing.

The normal confirm dialog shows a text with buttons 'ok' and 'cancel'. More information is needed here for a user to make the right decision. This gem therefore also adds:

* data-confirm-fade (default: false)
* data-confirm-title (default: window.top.location.origin)
* data-confirm-cancel (default: 'cancel')
* data-confirm-cancel-class (default: 'btn cancel')
* data-confirm-proceed (default: 'ok')
* data-confirm-proceed-class (default: 'btn-primary')

This behaviour is similar to that of a "regular" confirm box in ways that it uses the same title and button labels. Defaults can be changed in two ways:

Changing all default values:

    $.fn.twitter_bootstrap_confirmbox.defaults = {
        fade: false,
        title: null, // if title equals null window.top.location.origin is used
        cancel: "Cancel",
        cancel_class: "btn cancel",
        proceed: "OK",
        proceed_class: "btn proceed btn-primary"
    };

Only changing one default value:

    $.fn.twitter_bootstrap_confirmbox.defaults.proceed_class = "btn proceed btn-success";


## Installation

Add this line to your application's Gemfile:

    gem 'twitter-bootstrap-rails-confirm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twitter-bootstrap-rails-confirm

## Usage

Add it to your application.js, anywhere after you require jquery_ujs:

    //= require twitter/bootstrap/rails/confirm

Next... nothing. There is nothing you need to do to get this working. A helper could be useful for handling large amount of destroy buttons:

    def destroy_link_to(path, options)
      link_to t('.destroy'), path, 
        :method => :delete,
        :class => "btn",
        :confirm => t('.destroy_confirm.body', :item => options[:item]),
        "data-confirm-fade" => true,
        "data-confirm-title" => t('.destroy_confirm.title', :item => options[:item]),
        "data-confirm-cancel" => t('.destroy_confirm.cancel', :item => options[:item]),
        "data-confirm-cancel-class" => "btn-cancel"),
        "data-confirm-proceed" => t('.destroy_confirm.proceed', :item => options[:item]),
        "data-confirm-proceed-class" => "btn-danger"
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog

### In active development

* Javascript testing using Jasmine

### Upcoming release

* [(kramerc)](https://github.com/kramerc) [Prevent the default action on the modal's buttons.](https://github.com/bluerail/twitter-bootstrap-rails-confirm/pull/9)
* [(taavo)](https://github.com/taavo) [click handler returns false](https://github.com/bluerail/twitter-bootstrap-rails-confirm/pull/6)

### 1.0.1 (April 23, 2013)

* [(kramerc)](https://github.com/kramerc) [Add an option for including the fade class](https://github.com/bluerail/twitter-bootstrap-rails-confirm/pull/8)
* [(taavo)](https://github.com/taavo) [Load asap](https://github.com/bluerail/twitter-bootstrap-rails-confirm/pull/5)

### 1.0.0 (February 22, 2013)

* First 'official' release
* Many thanks to [taavo](https://github.com/taavo) for his contributions
