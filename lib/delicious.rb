require 'sinatra/base'

require_relative 'helpers'

# All delicious feeds accept a count parameter
# ?count={1..100} to limit the number of results (default 15)

module Delicious
  class FeedsApp < Sinatra::Base
    helpers Helpers

    delicious_url = 'http://feeds.delicious.com/v2/json'

    # Filters
    before '/feed*' do
      @count = count_param(params[:count])
    end

    after '/feed*' do
      content_type :json
    end

    # Hotlist bookmarks
    get '/feed' do
      result = get_json "#{delicious_url}#{@count}"
      # TODO: tweak the response, thumbnail links, etc.
      result.to_json
    end

    # Recent bookmarks
    get '/feed/recent' do
      result = get_json "#{delicious_url}/recent#{@count}"
      result.to_json
    end

    # Bookmarks by tags
    get '/feed/tag/:tags' do |tags|
      result = get_json "#{delicious_url}/tag/#{tags.split.join '+'}#{@count}"
      result.to_json
    end

    # Popular bookmarks
    get '/feed/popular' do
      result = get_json "#{delicious_url}/popular#{@count}"
      result.to_json
    end

    # Popular bookmarks by tag
    get '/feed/popular/:tag' do |tag|
      result = get_json "#{delicious_url}/popular/#{tag}#{@count}"
      result.to_json
    end

    # User's public bookmarks
    get '/feed/:username' do |username|
      result = get_json "#{delicious_url}/#{username}#{@count}"
      result.to_json
    end

    #User's public bookmakrs by tags
    get '/feed/:username/:tags' do |username, tags|
      result = get_json "#{delicious_url}/#{username}/#{tags.split.join '+'}#{@count}"
      result.to_json
    end

    not_found do
      halt 404, 'Page not found'
    end
  end
end
