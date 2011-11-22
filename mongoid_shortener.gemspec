$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mongoid_shortener/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mongoid_shortener"
  s.version     = MongoidShortener::VERSION
  s.authors     = ["Teng Siong Ong"]
  s.email       = ["siong1987@gmail.com"]
  s.homepage    = ""
  s.summary     = "MongoidShortener is a simple Rails 3.1 engine that shortens URL based on Mongoid."
  s.description = "MongoidShortener is a simple Rails 3.1 engine that shortens URL based on Mongoid."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.1"
  s.add_dependency "yab62", "1.0.1"

  s.add_development_dependency "sqlite3"
end
