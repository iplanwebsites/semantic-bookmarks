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

# All delicious feeds accept a count parameter
# ?count={1..100} to limit the number of results (default 15)

# Hotlist bookmarks
get '/api/v1/delicious/feed' do
  content_type :json
  count = count_param(params[:count])
  result = get_json "#{delicious_url}#{count}"

  # TODO: tweak the response, thumbnail links, etc.
  result.to_json
end

# Recent bookmarks
get '/api/v1/delicious/feed/recent' do
  content_type :json
  count = count_param(params[:count])
  result = get_json "#{delicious_url}/recent#{count}"

  result.to_json
end

# Bookmarks by tag
get '/api/v1/delicious/feed/tag/:tags' do
  content_type :json
  count = count_param(params[:count])
  result = get_json "#{delicious_url}/tag/#{params[:tags].split.join '+'}#{count}"

  result.to_json
end

# Popular bookmarks
get '/api/v1/delicious/feed/popular' do
  content_type :json
  count = count_param(params[:count])
  result = get_json "#{delicious_url}/popular#{count}"

  result.to_json
end

# Popular bookmarks by tag
get '/api/v1/delicious/feed/popular/:tag' do
  content_type :json
  count = count_param(params[:count])
  result = get_json "#{delicious_url}/popular/#{params[:tag]}#{count}"

  result.to_json
end

# User's public bookmarks
get '/api/v1/delicious/feed/:username' do
  content_type :json
  count = count_param(params[:count])
  result = get_json "#{delicious_url}/#{params[:username]}#{count}"

  result.to_json
end

not_found do
  halt 404, 'Page not found'
end
