lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pax/version'

Gem::Specification.new do |s|
  s.name = "pax"
  s.version = PAX::VERSION
  s.date = "2013-12-10"
  s.summary = "pax"
  s.description = "A small gem to help with scraping the Penny Arcade Expo website."
  s.authors = ["Patrick Neff"]
  s.email = "patrick.neff@me.com"
  s.homepage = "http://github.com/hersha/pax"

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'mechanize'
  s.required_ruby_version = '>= 1.9.3'
    
end
