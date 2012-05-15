require 'test/unit'
require File.expand_path("../../test_helper", __FILE__)
require 'net/http'
class HelloWorldTest < Test::Unit::TestCase
  def test_it_says_hello_world
    q = SingletonQueue.get
    q.enq(httpinate("hello world"))

    url = URI.parse('http://localhost:6868/hello')
    req = Net::HTTP::Get.new(url.path)

    res = Net::HTTP.start(url.host,url.port) do |http|
      http.request(req)
    end

    assert_equal res.body, "hello world"
  end
end
