require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require_relative 'helpers'

delicious_url = 'http://feeds.delicious.com/v2/json'

helpers Helpers

set :views, File.join(File.dirname(__FILE__), '..', 'views')

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
