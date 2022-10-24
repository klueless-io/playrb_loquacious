# frozen_string_literal: true

require_relative 'lib/playrb_loquacious/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version  = '>= 2.5'
  spec.name                   = 'playrb_loquacious'
  spec.version                = PlayrbLoquacious::VERSION
  spec.authors                = ['David']
  spec.email                  = ['david@ideasmen.com.au']

  spec.summary                = 'Playrb Loquacious is a Ruby playground project for understanding the Loquacious GEM'
  spec.description            = 'Playrb Loquacious is a Ruby playground project for understanding the Loquacious GEM'
  spec.homepage               = 'http://appydave.com/play-with-ruby/loquacious'
  spec.license                = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/klueless-io/playrb_loquacious'
  spec.metadata['changelog_uri'] = 'https://github.com/klueless-io/playrb_loquacious/commits/master'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the RubyGem files that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions    = ['ext/playrb_loquacious/extconf.rb']

  spec.add_dependency 'loquacious'
end
