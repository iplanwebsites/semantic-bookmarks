require 'sinatra'
require 'json'
require 'net/http'

helpers do
  def delicious_url
    'http://feeds.delicious.com/v2/json'
  end

  def get_url(url)
    Net::HTTP.get_response(URI.parse(url))
  end

  def get_json(url)
    resp = get_url url
    JSON.parse resp.body
  end
end

get '/' do
  erb :index
end

# Hotlist bookmarks
get '/api/v1/delicious/feed' do
  content_type :json
  result = get_json delicious_url

  # TODO: tweak the response, thumbnail links, etc.
  result.to_json
end

# Recent bookmarks
get '/api/v1/delicious/feed/recent' do
  content_type :json
  result = get_json "#{delicious_url}/recent"

  result.to_json
end

not_found do
  halt 404, 'Page not found'
end
