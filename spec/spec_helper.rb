ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.setup

require 'rack/test'
require_relative '../lib/helpers'
require_relative '../lib/semantic_bookmarks'
require_relative '../lib/delicious'

module RSpecMixin
  include Rack::Test::Methods
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.include Helpers
end
