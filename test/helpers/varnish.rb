STATUSES = {
  200 => "OK",
  418 => "I'm a teapot"
}

class Test::Unit::TestCase
  def q
    SingletonQueue.get
  end

  def expect(method, path, body, headers = {}, &block)

    # Pass the response into the http server
    q.enq(httpinate(body))

    # TODO Configurable port
    url = URI.parse('http://localhost:6868')
    req = requester(method).new(path)
    res = Net::HTTP.start(url.host,url.port) do |http|
      http.request(req)
    end

    req = q.deq

    block.call(res, req)
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

  def httpinate(body, status=200)
    return <<-HTTP
HTTP/1.0 #{status} #{STATUSES[status]}
Content-Type: text/html
Content-Length: #{body.length}

#{body}
    HTTP
  end

  def get(path, hdr, &block)
    @paths << [path, hdr, block]
  end

  def paths
    @paths ||= Array.new
  end

end
