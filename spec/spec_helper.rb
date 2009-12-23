$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'outfox'
require 'spec'
require 'spec/autorun'
require 'active_support'

Spec::Runner.configure do |config|
  
end

FIXTURES_PATH = File.join(File.dirname(__FILE__), 'fixtures') unless defined?(FIXTURES_PATH)
CONFIG_PATH = File.join(File.dirname(__FILE__), 'config') unless defined?(CONFIG_PATH)
