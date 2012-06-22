require "twitter-bootstrap-rails-confirm/version"

module Twitter
  module Bootstrap
    module Rails
      module Confirm
        require 'twitter-bootstrap-rails-confirm/engine' if defined?(Rails)
      end
    end
  end
end
