# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

class ActiveSupport::TestCase
  setup do
    MongoidShortener::ShortenedUrl.delete_all
    MongoidShortener.root_url = "http://localhost:3000"
    MongoidShortener.prefix_url = "http://localhost:3000/~"
  end
end

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
