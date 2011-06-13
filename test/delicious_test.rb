begin
  # try to use require_relative first
  # this only works for 1.9
  require_relative '../delicious.rb'
rescue NameError
  # oops, must be using 1.8
  require File.expand_path('../delicious.rb', __FILE__)
end

require 'test/unit'
require 'rack/test'

# TODO: use RSpec or a similar test framework
class DeliciousTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_default
    get '/'
    assert last_response.ok?
    assert last_response.body.include? 'Discover interesting websites'
  end

  def test_delicious_feed
    # TODO: use https://github.com/bblimke/webmock to stub http requests?
    # get '/api/v1/delicious/feed'

  end
end
