module MongoidShortener
  module ShortenedUrlsHelper
    # generate a url from either a url string, or a shortened url object
    def shortened_url(url)
      raise "Only String accepted: #{url}" unless url.class == String
      short_url = MongoidShortener::ShortenedUrl.generate(url)
      short_url
    end
  end
end
