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
# ?count={1..100} to limit the number of results (default 15)
get '/api/v1/delicious/feed' do
  content_type :json
  count = "?count=#{params[:count]}" if params[:count]
  result = get_json "#{delicious_url}#{count}"

  # TODO: tweak the response, thumbnail links, etc.
  result.to_json
end

# Recent bookmarks
# ?count={1..100} to limit the number of results (default 15)
get '/api/v1/delicious/feed/recent' do
  content_type :json
  count = "?count=#{params[:count]}" if params[:count]
  result = get_json "#{delicious_url}/recent#{count}"

  result.to_json
end

not_found do
  halt 404, 'Page not found'
end
