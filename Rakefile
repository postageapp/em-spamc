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
  gem.name = "em-spamc"
  gem.homepage = "http://github.com/twg/em-spamc"
  gem.license = "MIT"
  gem.summary = %Q{SpamAssassin Connection for EventMachine}
  gem.description = %Q{Implementation of the "spamc" protocol for EventMachine}
  gem.email = "github@tadman.ca"
  gem.authors = [ "Scott Tadman", "Stephan Leroux" ]
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task default: :test
