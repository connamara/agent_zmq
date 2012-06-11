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
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "agent_zeromq"
  gem.homepage = "git://git.connamara.com/agent_zeromq.git"
  gem.license = "Connamara"
  gem.summary = %Q{Acceptance test framework for ZMQ applications}
  gem.description = %Q{Acceptance test framework for ZMQ applications. Includes some cucumber helpers.}
  gem.email = "support@connamara.com"
  gem.authors = ["Chris Busbey"]
  # dependencies defined in Gemfile
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--color --format pretty --format junit --out features/reports}
end
