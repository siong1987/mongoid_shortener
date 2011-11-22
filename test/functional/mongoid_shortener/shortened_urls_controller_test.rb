require 'test_helper'

module MongoidShortener
  class ShortenedUrlsControllerTest < ActionController::TestCase
    test "get non-existence unique key" do
      get :translate, {unique_key: "~123"}
      assert_response :redirect
      assert_redirected_to "http://localhost:3000"
    end

    test "get valid unique key" do
      short_url = MongoidShortener.generate("http://google.com")
      unique_key = short_url[short_url.index("~")..-1]
      get :translate, {unique_key: unique_key}
      assert_response :redirect
      assert_redirected_to "http://google.com"
    end

    test "changing redirect root_url" do
      MongoidShortener.root_url = "http://google.com"
      get :translate, {unique_key: "~123"}
      assert_response :redirect
      assert_redirected_to "http://google.com"
    end

    test "redirect to non-valid key should raise exception" do
      assert_raise(ActionController::RoutingError) {
        get :translate, {unique_key: "123"}
      }
    end
  end
end
