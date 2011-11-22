require "mongoid_shortener/engine"

module MongoidShortener
  # The prefix_url for generated shortened url
  mattr_accessor :prefix_url, :root_url
  @@root_url = "http://localhost:3000"
  @@prefix_url = "http://localhost:3000/~"

  def self.generate url
    ShortenedUrl.generate url
  end
end
