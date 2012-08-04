# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "chooseme/version"

Gem::Specification.new do |s|
  s.name        = "chooseme"
  s.version     = Chooseme::VERSION
  s.authors     = ["Pavel Manylov"]
  s.email       = ["rapkasta@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Choose index for your database query}
  s.description = %q{Pass table name or model with used columns and get right database index to use}

  s.rubyforge_project = "chooseme"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('rails', '>= 3.0', '< 4.0')

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
