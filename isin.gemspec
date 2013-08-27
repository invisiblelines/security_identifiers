# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'isin/version'

Gem::Specification.new do |s|
  s.name          = "isin"
  s.version       = ISIN::VERSION
  s.authors       = ["Kieran Johnson"]
  s.email         = ["hello@invisiblelines.com"]
  s.summary       = %q{ISIN valiation library for Ruby}
  s.description   = s.summary
  s.homepage      = ""
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
end
