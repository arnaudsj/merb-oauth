require 'rubygems'
require 'spec'
$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'merb-core'
require 'merb_oauth/merb_request'
require 'merb_oauth/oauth_mixin'
require 'logger'
require 'net/http'

Spec::Runner.configure do |config|
  config.include(Merb::Test::ControllerHelper)
  
  config.mock_with :mocha
end

Merb::Config.use { |c|
  c[:framework]           = {},
  c[:session_store]       = 'none',
  c[:exception_details]   = true,
  c[:log_level]           = :debug,
  c[:log_stream]          = STDOUT
}

Merb::Controller.send :include, OAuthMixin