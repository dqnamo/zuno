# frozen_string_literal: true

require_relative "lib/zuno/version"

Gem::Specification.new do |spec|
  spec.name = "zuno"
  spec.version = Zuno::VERSION
  spec.authors = ["John Paul"]
  spec.email = ["johnarpaul@gmail.com"]

  spec.summary = "AI toolkit for Ruby"
  spec.description = "AI toolkit for Ruby"
  spec.homepage = "https://github.com/dqnamo"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = "https://github.com/dqnamo"
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = ["lib/zuno/version.rb", "lib/zuno.rb", "lib/zuno/chat.rb", "lib/providers/openai.rb",
                "lib/providers/anthropic.rb", "lib/zuno/configuration.rb", "lib/zuno/transcription.rb",
                "lib/providers/groq_cloud.rb"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
