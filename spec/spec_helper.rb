require 'bundler/setup'
Bundler.setup

require 'sketchfably' 
require 'json'
require 'webmock/rspec'
require 'rspec/its'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  json_response = File.read(File.join(File.dirname(__FILE__), "fixtures", "api_tag_response.json"))
  config.before(:each) do
    stub_request(:get, /api.sketchfab.com/).to_return(status: 200, body: json_response, headers: {})
  end
end

