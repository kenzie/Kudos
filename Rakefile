require 'bundler/setup'
require 'rake/testtask'

namespace :jobs do
  desc "Heroku worker"
  task :work do
    exec('ruby ./lib/daemon.rb')
  end
end

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  # t.warning = true
  t.verbose = true
  t.test_files = FileList['spec/**/*_spec.rb']
end