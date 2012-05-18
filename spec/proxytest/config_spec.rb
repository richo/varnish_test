require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProxyTest::Config do

  it "Should not have any values until initialized" do
    ::ProxyTest::Config.backend_port.should be_nil
    ::ProxyTest::Config.backend_host.should be_nil
    ::ProxyTest::Config.proxy_port.should be_nil
    ::ProxyTest::Config.proxy_host.should be_nil

    ::ProxyTest::Config.pattern.should be_nil
  end

  it "Should inherit sane defaults for host config" do
    ::ProxyTest::config do |conf|
    end

    ::ProxyTest::Config.backend_host.should == "localhost"
    ::ProxyTest::Config.proxy_host.should == "localhost"
  end

  it "Should inherit sane default for pattern" do
    ::ProxyTest::config do |conf|
    end

    ::ProxyTest::Config.pattern.should == "proxytest/**/*_test.rb"
  end

  it "Should store hostnames given" do
    ::ProxyTest::config do |conf|
      conf.backend_host = "richo-mbp"
      conf.proxy_host = "richo-mbp"
    end

    ::ProxyTest::Config.backend_host.should == "richo-mbp"
    ::ProxyTest::Config.proxy_host.should == "richo-mbp"
  end

  it "Should store ports given" do
    ::ProxyTest::config do |conf|
      conf.backend_port = 2257
      conf.proxy_port = 2256
    end

    ::ProxyTest::Config.backend_port.should == 2257
    ::ProxyTest::Config.proxy_port.should == 2256
  end

  it "Should not clobber config on subsequent passes" do
    ::ProxyTest::config do |conf|
      conf.backend_port = 2257
      conf.proxy_port = 2256
    end
    ::ProxyTest::config do |conf|
      conf.backend_host = "richo-mbp"
      conf.proxy_host = "richo-mbp"
    end

    ::ProxyTest::Config.backend_host.should == "richo-mbp"
    ::ProxyTest::Config.proxy_host.should == "richo-mbp"
    ::ProxyTest::Config.backend_port.should == 2257
    ::ProxyTest::Config.proxy_port.should == 2256
  end

end
