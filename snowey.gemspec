# -*- encoding: utf-8 -*-
require File.expand_path('../lib/snowey/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tom Arnfeld"]
  gem.email         = ["tarnfeld@me.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "http://github.com/tarnfeld/snowey"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "snowey"
  gem.require_paths = ["lib"]
  gem.version       = Snowey::VERSION
end
