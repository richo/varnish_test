module ProxyTest; extend self
  def config
    ::ProxyTest::Config.seed_from_environment!
    yield ::ProxyTest::Config
  end
end

module ProxyTest
  class Config; class << self
    attr_accessor :backend_port, :backend_host
    attr_accessor :proxy_port, :proxy_host
    attr_accessor :pattern

    def seed_from_environment!
      # Doesn't touch any values that have already been set
      @pattern ||= "proxytest/**/*_test.rb"

      @backend_port ||= ENV["BACKEND_PORT"]
      @backend_host ||= ENV["BACKEND_HOST"] || "localhost"
      @proxy_port   ||= ENV["PROXY_PORT"]
      @proxy_host   ||= ENV["PROXY_HOST"] || "localhost"
    end
  end; end
end
