require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

# For docs
require 'yard'
require "yard-tomdoc"

YARD::Rake::YardocTask.new do |t|
 t.files   = ['lib/**/*.rb']
 t.options = ['--plugin=tomdoc', '--hide-void-return', '--title="Daily Log"']
 t.stats_options = ['--list-undoc']
end

task doc: :yard
