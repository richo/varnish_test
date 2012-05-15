STATUSES = {
  200 => "OK",
  418 => "I'm a teapot"
}

class Test::Unit::TestCase
  def httpinate(body, status=200)
    return <<-HTTP
HTTP/1.0 #{status} #{STATUSES[status]}
Content-Type: text/html
Content-Length: #{body.length}

#{body}
    HTTP
  end
end
