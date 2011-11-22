require 'test_helper'

module MongoidShortener
  class ShortenedUrlTest < ActiveSupport::TestCase
    test "shorten invalid url" do
      assert_nil MongoidShortener.generate "ahha"
    end

    test "shorten valid url with http" do
      assert_equal("http://localhost:3000/~0", MongoidShortener.generate("http://google.com"))
    end

    test "shorten valid url without http" do
      assert_equal("http://localhost:3000/~0", MongoidShortener.generate("yahoo.com"))
    end

    test "reshorten the same valid url" do
      assert_equal("http://localhost:3000/~0", MongoidShortener.generate("http://google.com"))
      assert_equal("http://localhost:3000/~0", MongoidShortener.generate("google.com"))
    end

    test "shorten two valid url" do
      assert_equal("http://localhost:3000/~0", MongoidShortener.generate("google.com"))
      assert_equal("http://localhost:3000/~1", MongoidShortener.generate("yahoo.com"))
    end

    test "set prefix_url" do
      MongoidShortener.prefix_url = "http://dailymus.es/~"
      assert_equal("http://dailymus.es/~", MongoidShortener.prefix_url)
      assert_equal("http://dailymus.es/~0", MongoidShortener.generate("yahoo.com"))
    end
  end
end
