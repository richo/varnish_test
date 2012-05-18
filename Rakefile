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
  SingletonQueue.get.join!
end
