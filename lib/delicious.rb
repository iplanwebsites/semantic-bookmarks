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

# Filters
before '/api/v1/delicious/feed*' do
  @count = count_param(params[:count])
end

after '/api/v1/delicious/feed*' do
  content_type :json
end

# Hotlist bookmarks
get '/api/v1/delicious/feed' do
  result = get_json "#{delicious_url}#{@count}"
  # TODO: tweak the response, thumbnail links, etc.
  result.to_json
end

# Recent bookmarks
get '/api/v1/delicious/feed/recent' do
  result = get_json "#{delicious_url}/recent#{@count}"
  result.to_json
end

# Bookmarks by tags
get '/api/v1/delicious/feed/tag/:tags' do |tags|
  result = get_json "#{delicious_url}/tag/#{tags.split.join '+'}#{@count}"
  result.to_json
end

# Popular bookmarks
get '/api/v1/delicious/feed/popular' do
  result = get_json "#{delicious_url}/popular#{@count}"
  result.to_json
end

# Popular bookmarks by tag
get '/api/v1/delicious/feed/popular/:tag' do |tag|
  result = get_json "#{delicious_url}/popular/#{tag}#{@count}"
  result.to_json
end

# User's public bookmarks
get '/api/v1/delicious/feed/:username' do |username|
  result = get_json "#{delicious_url}/#{username}#{@count}"
  result.to_json
end

#User's public bookmakrs by tags
get '/api/v1/delicious/feed/:username/:tags' do |username, tags|
  result = get_json "#{delicious_url}/#{username}/#{tags.split.join '+'}#{@count}"
  result.to_json
end

not_found do
  halt 404, 'Page not found'
end
