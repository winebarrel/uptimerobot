# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uptimerobot/version'

Gem::Specification.new do |spec|
  spec.name          = 'uptimerobot'
  spec.version       = UptimeRobot::GEM_VERSION
  spec.authors       = ['Genki Sugawara', 'Diego Augusto Ramos']
  spec.email         = ['sgwr_dts@yahoo.co.jp', 'diego.ramos@adtsys.com.br']
  spec.summary       = %q{Uptime Robot API client for Ruby.}
  spec.description   = %q{Uptime Robot API client for Ruby.}
  spec.homepage      = 'https://github.com/adtsys/uptimerobot'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '>= 0.8'
  spec.add_dependency 'faraday_middleware'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
end
