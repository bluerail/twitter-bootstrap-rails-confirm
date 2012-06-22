# -*- encoding: utf-8 -*-
require File.expand_path('../lib/twitter-bootstrap-rails-confirm/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rene van Lieshout"]
  gem.email         = ["rene@bluerail.nl"]
  gem.description   = %q{Confirm dialogs using Twitter Bootstrap}
  gem.summary       = %q{Applies a custom confirm dialog for elements with a data-confirm attribute.}
  gem.homepage      = "https://github.com/bluerail/twitter-bootstrap-rails-confirm"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "twitter-bootstrap-rails-confirm"
  gem.require_paths = ["lib", "vendor"]
  gem.version       = Twitter::Bootstrap::Rails::Confirm::VERSION
end
