# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'configureasy/version'

Gem::Specification.new do |spec|
  spec.name          = "configureasy"
  spec.version       = Configureasy::VERSION
  spec.authors       = ["Alexandre Prates"]
  spec.email         = ["ajfprates@gmail.com"]
  spec.summary       = %q{A Simple way to get configs in your Classes/Modules.}
  spec.description   = %q{A Simple way to get configs in your Classes/Modules.}
  spec.homepage      = "https://gitlab.ir7.com.br/videos/configureasy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "guard", "~> 2.10"
  spec.add_development_dependency "guard-rspec", "~> 4.5"
end
