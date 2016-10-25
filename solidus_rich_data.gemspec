# encoding: UTF-8
$:.push File.expand_path('../lib', __FILE__)
require 'solidus_rich_data/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_rich_data'
  s.version     = SolidusRichData::VERSION
  s.summary     = 'Adds Open Graph, Schema.org, Rich Pins & Twitter Cards'
  s.description =  "Third party websites often use extractors to pull in rich content. " \
                   "This extension allows you to add custom titles, descriptions and images " \
                   "so you're always pulling in the correct photos, instead of the logo and " \
                   "SEO <title> which doesn't always make sense for social sharing."
  s.license     = 'BSD-3-Clause'

  s.author      = 'Ryan Siddle'
  s.email       = 'ryan.siddle@merj.com'
  s.homepage    = 'http://merj.com'

  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'solidus_core', '~> 2.0'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop', '0.37.2'
  s.add_development_dependency 'rubocop-rspec', '1.4.0'
  s.add_development_dependency 'simplecov'
end
