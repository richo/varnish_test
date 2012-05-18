require File.expand_path("../../test_helper", __FILE__)
class ImaTeapotTest < ProxyTest::TestCase
  def test_it_is_a_teapot
    res, req = expect :get, "/teapot" do |response, request|
      response.status = 418
      response.body = "I'm a teapot, yo"
    end

    assert_equal res.body, "I'm a teapot, yo"
    assert_equal res.code.to_i, 418
  end
end

