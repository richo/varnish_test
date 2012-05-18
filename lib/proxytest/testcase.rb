
class ProxyTest::TestCase < Test::Unit::TestCase
  def q
    SingletonQueue.get
  end

  def expect(method, path, &block)
    # Create stub objects for the response and the request
    url = URI.parse('http://localhost:6868')
    mock_req = requester(method).new(path)
    mock_res = ::VarnishTest::Response.new

    yield(mock_res, mock_req)

    # Pass the response into the http server
    q.enq(mock_res.to_http)

    # TODO Configurable port
    real_res = Net::HTTP.start(url.host,url.port) do |http|
      http.request(mock_req)
    end

    real_req = q.deq

    [real_res, real_req]
  end

  def requester(sym)
    case sym
    when :get
      Net::HTTP::Get
    when :post
      Net::HTTP::Post
    when :put
      Net::HTTP::Put
    when :head
      Net::HTTP::Head
    else
      raise "Unsupported HTTP verb"
    end
  end


  def get(path, hdr, &block)
    @paths << [path, hdr, block]
  end

  def paths
    @paths ||= Array.new
  end

end
