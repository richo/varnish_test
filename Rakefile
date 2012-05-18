require 'rake'
require 'rake/testtask'

desc "Run basic tests"
Rake::TestTask.new("test") { |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = true
}

desc "Start the singletonqueue server"
task :serve do
  require './test/helpers/backend'
  q = SingletonQueue.new
  loop do
    q.enq("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n")
  end
end
