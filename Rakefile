require 'rake'
require 'rake/testtask'

desc "Run basic tests"
Rake::TestTask.new("test") { |t|
  t.pattern = 'test/**/test_*.rb'
  t.verbose = true
  t.warning = true
}
