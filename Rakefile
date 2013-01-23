require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'

desc "Run the example suite"
Rake::TestTask.new("examples") { |t|
  t.pattern = 'examples/**/*_test.rb'
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

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
end
