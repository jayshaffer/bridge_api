# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'bridge_api/version'

Gem::Specification.new do |gem|
  gem.authors =       ["Jay Shaffer"]
  gem.email =         ["jshaffer@instructure.com"]
  gem.description =   %q{Ruby gem for interacting with the bridge API}
  gem.summary =       %q{Bridge API}
  gem.homepage =      "https://getbridge.com"
  gem.license = 'MIT'

  gem.files = `git ls-files`.split("\n")
  gem.files += Dir.glob("lib/**/*.rb")
  gem.files += Dir.glob("spec/**/*")
  gem.test_files    = Dir.glob("spec/**/*")
  gem.name          = "bridge_api"
  gem.require_paths = ["lib"]
  gem.version       = BridgeAPI::VERSION

  gem.add_development_dependency 'rake', '~> 0'
  gem.add_development_dependency 'bundler', '~> 1.0', '>= 1.0.0'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'webmock', '~> 0'
  gem.add_development_dependency 'pry', '~> 0'
  gem.add_development_dependency 'tilt', '>= 1.3.4', '~> 1.3'

  gem.add_dependency 'footrest', '~> 0.2', '>= 0.2.2'

end
