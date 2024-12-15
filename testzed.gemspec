# frozen_string_literal: true

require_relative "lib/testzed/version"

Gem::Specification.new do |spec|
  spec.name = "testzed"
  spec.version = Testzed::VERSION
  spec.authors = ["Aji Slater"]
  spec.email = ["aji.slater@gmail.com"]

  spec.summary = "An in-ruby test client for Authzed/SpiceDB"
  spec.description = "In order to be able to test that your code works as expected with your schema, but without needing to run a full instance of Authzed/SpiceDB or directly mock out GRPC, you can use this gem."
  spec.homepage = "https://github.com/thoughtbot/testzed"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/thoughtbot/testzed"
  spec.metadata["changelog_uri"] = "https://github.com/thoughtbot/testzed/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ lib/ test/ .git .github Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.license = "MIT"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
