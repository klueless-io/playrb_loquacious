# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rake/extensiontask'

task build: :compile

Rake::ExtensionTask.new('playrb_loquacious') do |ext|
  ext.lib_dir = 'lib/playrb_loquacious'
end

task default: %i[clobber compile spec]
