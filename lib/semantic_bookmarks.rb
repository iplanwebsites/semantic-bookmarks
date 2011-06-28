require 'sinatra/base'
require 'mongo_mapper'
require 'sinatra-authentication'

class SemanticBookmarksApp < Sinatra::Base

  enable :static, :session
  use Rack::Session::Cookie, :secret => 'A1 sauce 1s so good you should use 1t on a11 yr st34ksssss'
  set :views, File.join(File.dirname(__FILE__), '..', 'views')

  get '/' do
    erb :index
  end
  
  get '/alpha' do #once session and invite system will work, we can merge this in the main URL and toggle
    erb :alpha
  end

  not_found do
    halt 404, 'Page not found'
  end

end
