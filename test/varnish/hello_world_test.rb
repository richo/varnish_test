require File.expand_path("../../test_helper", __FILE__)
class HelloWorldTest < Test::Unit::TestCase
  def test_it_says_hello_world
    # Returns the real objects from the transaction
    res, req = expect :get, "/hello" do |response, request|
      # Modify the request inline
      request["X-Someotherheader"] = "thing"

      # Modify the response inline
      response.body = "body goes here"
      response["X-Someheader"] = "value"
    end

    # Assertions about response go here
    #
    assert_equal res.body, "body goes here"
    assert_equal req.env["REQUEST_METHOD"], "GET"
  end
end
