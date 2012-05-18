require File.expand_path("../../test_helper", __FILE__)
class HelloWorldTest < Test::Unit::TestCase
  def test_it_says_hello_world
    expect :get, "/hello", "body goes here", { "X-Someheader" => "value" } do |response, request|
      # Assertions about response go here
      assert_equal response.body, "body goes here"
      assert_equal request.env["REQUEST_METHOD"], "GET"
    end
  end
end
