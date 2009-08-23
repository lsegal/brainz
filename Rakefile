require 'spec'
require 'spec/rake/spectask'

desc "Run all specs"
Spec::Rake::SpecTask.new("specs") do |t|
  $DEBUG = true if ENV['DEBUG']
  t.spec_opts = ["--format", "specdoc", "--colour"]
  t.spec_opts += ["--require", File.join(File.dirname(__FILE__), 'spec', 'spec_helper')]
  t.spec_files = Dir["spec/**/*_spec.rb"].sort
  t.rcov = true if ENV['RCOV']
  t.rcov_opts = ['-x', '_spec\.rb$,spec_helper\.rb$']
end