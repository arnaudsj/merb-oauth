require 'rubygems'
require 'rake/gempackagetask'
require 'spec/rake/spectask'

PLUGIN = "merb_oauth"
NAME = "merb_oauth"
VERSION = "0.1"
AUTHOR = "Eric Allam"
EMAIL = "rubymaverick@gmail.com"
HOMEPAGE = "http://merb.devjavu.com"
SUMMARY = "Merb plugin that integrates the ruby OAuth gem into Merb"

spec = Gem::Specification.new do |s|
  s.name = NAME
  s.version = VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  #s.homepage = HOMEPAGE
  s.add_dependency('merb-core', '>= 0.9.4')
  s.require_path = 'lib'
  s.autorequire = PLUGIN
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,specs}/**/*")
end

windows = (PLATFORM =~ /win32|cygwin/) rescue nil

SUDO = windows ? "" : "sudo"

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install merb_param_protection"
task :install => [:package] do
  sh %{#{SUDO} gem install pkg/#{NAME}-#{VERSION} --no-rdoc --no-ri --no-update-sources}
end

desc 'Release the current version on rubyforge'
task :release => :package do
  sh %{rubyforge add_release merb #{PLUGIN} #{VERSION} pkg/#{NAME}-#{VERSION}.gem}
end

desc "Run all specs"
Spec::Rake::SpecTask.new('specs') do |t|
  t.spec_opts = ["--format", "specdoc", "--colour"]
  t.spec_files = Dir['spec/**/*_spec.rb'].sort
end

desc "RCov"
Spec::Rake::SpecTask.new("rcov") do |t|
  t.rcov_opts = ["--exclude", "gems", "--exclude", "spec"]
  t.spec_opts = ["--format", "specdoc", "--colour"]
  t.rcov_opts = ["--exclude","gems", "--exclude", "spec"]
  t.spec_files = Dir["spec/**/*_spec.rb"].sort
  t.libs = ["lib", "server/lib" ]
  t.rcov = true
end
