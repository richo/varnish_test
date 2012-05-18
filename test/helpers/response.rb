module VarnishTest
  STATUSES = {
    200 => "OK",
    418 => "I'm a teapot"
  }

  class Response
    attr_accessor :body
    attr_reader :headers

    def initialize
      body = ""
      # Default set of headers?
      @headers = {}
    end

    def to_http
      h1 =  <<-HTTP
HTTP/1.0 #{status} #{STATUSES[status]}
Content-Type: text/html
Content-Length: #{body.length}
HTTP
      headers.each do |k, v|
        h1 += "#{k}: #{v}\r\n"
      end

      h1 += <<-HTTP

#{body}
HTTP
      return h1
    end

    # Hack to make it look like a Net::HTTP entity
    def [](v)
      headers[v]
    end

    def []=(k, v)
      headers[k] = v
    end

    # Status wrapper
    def status
      @status ||= 200
    end

    def status=(st)
      @status = st
    end

  end
end
