$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'meme'
require 'spec'
require 'spec/autorun'
require 'open-uri'
require 'json'
require 'fakeweb'

Spec::Runner.configure do |config|
  
end
