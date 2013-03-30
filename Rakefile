require 'rubygems'
require 'rake'
require 'cucumber/rake/task'

task :default => [:test]
task :test => [:features]

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = '--format pretty'
end