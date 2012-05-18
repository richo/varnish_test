require 'test/unit'
require 'net/http'

require File.expand_path("../helpers/backend", __FILE__)
require File.expand_path("../helpers/varnish", __FILE__)
require File.expand_path("../helpers/response", __FILE__)

# Seed the queue by giving it a port

SingletonQueue.new
