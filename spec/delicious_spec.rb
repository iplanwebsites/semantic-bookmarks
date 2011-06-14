require_relative 'spec_helper'

describe 'The Delicious App' do

  it "should respond to /" do
    get '/'
    last_response.should be_ok
    last_response.headers["Content-Type"].should match(/text\/html/)
    last_response.should match(/Discover interesting websites/)
  end

  it "should return 404 when page cannot be found" do
    get '/404'
    last_response.status.should == 404
  end
end
