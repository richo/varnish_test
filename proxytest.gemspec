# vim: ft=ruby

Gem::Specification.new do |s|
  s.name        = "proxytest"
  s.version     = "0.0.0"
  s.authors     = ["Rich Healey"]
  s.email       = ["richo@99designs.com"]
  s.homepage    = "http://github.com/richo/proxytest"
  s.summary     = "A test framework for testing proxy logic"
  s.description = s.summary

  s.add_dependency "thin"

  s.add_development_dependency "rake"
  #s.add_development_dependency "mocha"
  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end


