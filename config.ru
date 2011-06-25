require 'bundler/setup'

require File.join(File.dirname(__FILE__), 'lib/semantic_bookmarks')
require File.join(File.dirname(__FILE__), 'lib/delicious')

map "/" do
  run SemanticBookmarksApp
end

map "/api/v1/delicious" do
  run Delicious::FeedsApp
end
