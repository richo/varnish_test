Test driven varnish ftw yo.

## Usage

```ruby

# Sample Rakefile
ProxyTest::Config do |conf|
  conf.backend_port = 2000
  conf.proxy_port   = 6868

  #conf.pattern = "proxytest/**/*_test.rb"

  #conf.backend_host = "localhost"
  #conf.proxy_host   = "localhost"
end

namespace :proxy do
  desc "Run proxy tests"
  task :test do
    ProxyTest.run!
  end
end
```
