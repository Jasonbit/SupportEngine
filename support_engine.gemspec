$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "support_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "support_engine"
  s.version     = SupportEngine::VERSION
  s.authors     = ["Gabriel Rios"]
  s.email       = ["gabrielfalcaorios@gmail.com"]
  s.homepage    = "http://www.orbitalimpact.com"
  s.summary     = "A simple open source helpdesk engine for rails apps"
  s.description  = "A simple open source helpdesk engine for rails apps"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.22"
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails"

  s.add_development_dependency "pry-rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'factory_girl_rails'
end
