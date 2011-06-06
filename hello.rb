require 'sinatra'
require 'mongo'
require 'sinatra/mongo'
require "sinatra/jsonp"

require 'freebase'
require 'json'
require 'digest/md5'

# require 'mongo_mapper' #for rails only...

require "sinatra-authentication"


# authentification using sinatra-auth:
# https://github.com/maxjustus/sinatra-authentication


# Json helper info:
# http://podtynnyi.com/2010/05/28/sinatra-jsonp-output-helper/

# mongo db in sinatra
# http://teachmetocode.com/screencasts/introduction-to-mongodb-part-ii/
# http://rubygems.org/gems/sinatra-mongo

get '/' do
  "Hello World! <a href='/lol'>Laugh page</a>"
end

get '/lol' do
  data = [["hello", "coucou"],'hi',"hallo", "hehe", 123, 10-4] 
  JSONP data # JSONP is an alias for jsonp method, will return JSON string to browser.
end


get '/profile' do
  data = [["hello", "coucou"],'hi',"hallo", "hehe", 123, 10-4] 
  
  


  # find out the user's gravatar URL
  email_address = "info@iplanwebsites.com"
  hash = Digest::MD5.hexdigest(email_address)
  avatar_src = "http://www.gravatar.com/avatar/#{hash}"

  JSONP data # JSONP is an alias for jsonp method, will return JSON string to browser.
end


not_found do  
  halt 404, 'page not found'  
end

