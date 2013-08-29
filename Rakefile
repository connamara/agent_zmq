# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:cucumber)

task :test => [:spec, :cucumber]
task :default => :test


require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "agent_zmq"
  gem.homepage = "https://github.com/connamara/agent_zmq"
  gem.license = "GPL"
  gem.summary = %Q{Acceptance test framework for ZeroMQ applications}
  gem.description = %Q{Acceptance test framework for ZeroMQ applications. Includes some cucumber helpers.}
  gem.email = "info@connamara.com"
  gem.authors = ["Chris Busbey"]
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new
