require 'sinatra'
require 'mongo'
require 'sinatra/mongo'
require "sinatra/jsonp"

require 'freebase'
require 'json'
require 'digest/md5'

# require 'mongo_mapper' #for rails only...

require "sinatra-authentication"


# snapshot images using yotta webservices:
# http://www.yottasnap.com/FAQ.aspx#SnapshotRequest
# OUR api key: 32bca3bd-44df-4c04-a093-bd236912fcca
# mode = FixedWidthAndHeightAutoCrop 
# * we only have 5000 free snapshots for now.


# authentification using sinatra-auth:
# https://github.com/maxjustus/sinatra-authentication


# Json helper info:
# http://podtynnyi.com/2010/05/28/sinatra-jsonp-output-helper/

# mongo db in sinatra
# http://teachmetocode.com/screencasts/introduction-to-mongodb-part-ii/
# http://rubygems.org/gems/sinatra-mongo


# mongo connection...
#uri =  URI.parse(ENV['MONGOHQ_URL'])
#@mongo_connection = Mongo::Connection.from_uri( uri )
#@mongo_db.authenticate(uri.user, uri.password)






get '/' do
  "Hello World! <a href='/lol'>Laugh page</a>"
end

get '/add-bookmark' do
 # When adding a new bookmark:
    # Clean the domain name
    # If  already indexed, bump the fav counter, else,:
      # CURL the homepage
      # parse title, meta, and keywords (just strip-tags the whole page for now)
      # Fetch the thumbnail URL at YottaSnap. (maybe wait until there's 2-3 bookmarkers to avoid caching spam domain images?)
    
      # we can then call robots-scripts after.
        # check if google-ads are presents on page
        # check if FB is there too
        # check if there's an news feed (rss)?
        # check PR? - probably too costly, and not very usefull anyway...
        
      
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

