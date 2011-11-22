require 'test_helper'

module MongoidShortener
  class ShortenedUrlsHelperTest < ActionView::TestCase
    test "shortened invalid url" do
      assert_nil shortened_url("haha")
    end

    test "shorten valid url" do
      assert_equal("http://localhost:3000/~0", shortened_url("http://google.com"))
    end

    test "shorten two same url" do
      assert_equal("http://localhost:3000/~0", shortened_url("http://google.com"))
      assert_equal("http://localhost:3000/~0", shortened_url("http://google.com"))
    end
  end
end
