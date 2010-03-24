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

def load_fixture(name)
  File.join(File.expand_path(File.dirname(__FILE__)), '/fixtures', name)
end

def fake_web(query, fixture)
  url = URI.escape("https://query.yahooapis.com/v1/public/yql?q=#{query}&format=json")
  FakeWeb.register_uri(:get, url, :body => load_fixture(fixture))
end
