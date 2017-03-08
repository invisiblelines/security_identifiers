# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'security_identifiers/version'

Gem::Specification.new do |s|
  s.name          = "security_identifiers"
  s.version       = SecurityIdentifiers::VERSION
  s.authors       = ["Kieran Johnson"]
  s.email         = ["hello@invisiblelines.com"]
  s.summary       = %q{Security Identifier validation library for Ruby}
  s.description   = s.summary
  s.homepage      = ""
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake', '~> 12.0', '>= 12.0.0'
  s.add_development_dependency 'activemodel', '5.0.2'
  s.add_development_dependency 'guard', '2.12.1'
  s.add_development_dependency 'guard-rspec', '4.5.0'
  s.add_development_dependency 'rspec', '~> 3.5', '>= 3.5.0'
  s.add_development_dependency 'rubocop', '0.47.1'
end
