require File.expand_path( "../lib/asgit/version", __FILE__ )

Gem::Specification.new do |s|

  s.name          = 'asgit'
  s.version       = Asgit::VERSION
  s.platform      = Gem::Platform::RUBY

  s.summary       = 'A simple query interface for git'
  s.description   = %q{ A simple query interface for git. }
  s.authors       = ["Steven Sloan"]
  s.email         = ["stevenosloan@gmail.com"]
  s.homepage      = "http://github.com/stevenosloan/asgit"
  s.license       = 'MIT'

  s.files         = Dir["{lib}/**/*.rb"]
  s.test_files    = Dir["spec/**/*.rb"]
  s.require_path  = "lib"

end