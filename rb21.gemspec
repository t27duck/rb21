# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rb21/version"

Gem::Specification.new do |spec|
  spec.name          = "rb21"
  spec.version       = Rb21::VERSION
  spec.authors       = ["Tony Drake"]
  spec.email         = ["t27duck@gmail.com"]

  spec.summary       = "A basic implementation for the game of 21 (Blackjack)"
  spec.description   = "An example gem that can surve as a base for making a Blackjack game in Ruby"
  spec.homepage      = "https://github.com/t27duck/rb21"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
