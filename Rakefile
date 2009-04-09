require 'rubygems'
require 'rake/gempackagetask'
require 'spec/rake/spectask'

require 'merb-core'
require 'merb-core/tasks/merb'

GEM_NAME = "merb_oauth"
GEM_VERSION = "0.1.1"
AUTHOR = "Eric Allam"
EMAIL = "rubymaverick@gmail.com"
HOMEPAGE = "http://merb.devjavu.com"
SUMMARY = "Merb plugin that integrates the ruby OAuth gem into Merb"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'merb'
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('merb', '>= 1.0.10')
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{lib,spec}/**/*")
  
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the plugin as a gem"
task :install do
  Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION)
end

desc "Uninstall the gem"
task :uninstall do
  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['*_spec.rb']
  #t.options = '-v'
end

task :default  => :spec