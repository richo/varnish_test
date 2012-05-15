class Test::Unit::TestCase
  def httpinate(body)
    return <<-HTTP
HTTP/1.0 200 OK
Content-Type: text/html
Content-Length: #{body.length}

#{body}
    HTTP
  end
end
