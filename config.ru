path = File.expand_path "../", __FILE__

require "#{path}/delicious"

run Sinatra::Application
