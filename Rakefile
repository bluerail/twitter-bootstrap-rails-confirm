#!/usr/bin/env rake
require "bundler/gem_tasks"

task :default => [:jasmine]
task :jasmine do |t|
  sh "node_modules/jasmine-node/bin/jasmine-node", "--coffee", "--verbose", "spec"
end