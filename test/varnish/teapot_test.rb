require File.expand_path("../../test_helper", __FILE__)
class ImaTeapotTest < Test::Unit::TestCase
  def test_it_is_a_teapot
    q = SingletonQueue.get
    q.enq(httpinate("I'm a teapot, yo", 418))

    url = URI.parse('http://localhost:6868/hello')
    req = Net::HTTP::Get.new(url.path)

    res = Net::HTTP.start(url.host,url.port) do |http|
      http.request(req)
    end

    assert_equal res.body, "I'm a teapot, yo"
    assert_equal res.code.to_i, 418

  end
end

