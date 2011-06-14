require_relative 'spec_helper'

delicious_url = 'http://feeds.delicious.com/v2/json'

delicious_json = %{[{"u":"http:\/\/vimeo.com\/24302498","d":"29 WAYS TO STAY CREATIVE on Vimeo","t":["video","creative","design","inspiration","creativity","via:packrati.us","criatividade","art","creatividad","dise\u00f1o"],"dt":"2011-06-04T03:36:20Z"},{"u":"http:\/\/scribblinlenore.livejournal.com\/559093.html","d":"In Plain Sight","t":["x-men","erik\/charles","charles\/erik","nc-17","author:scribblinlenore","fanfic","fic","au","scribblinlenore","xmen"],"dt":"2011-06-13T02:52:26Z"}]}

describe 'The Delicious App' do

  it 'should respond to /' do
    get '/'
    last_response.should be_ok
    last_response.headers['Content-Type'].should match(/text\/html/)
    last_response.should match(/Discover interesting websites/)
  end

  it 'should fetch hotlist bookmarks from delicious' do
    mock_req = double('http request')
    mock_req.should_receive(:body) { delicious_json }
    Net::HTTP.should_receive(:get_response).with(URI.parse(delicious_url)) { mock_req }

    get '/api/v1/delicious/feed'
    last_response.should be_ok
    last_response.headers['Content-Type'].should == 'application/json'
    last_response.body.should == delicious_json
    JSON.parse(last_response.body).length.should == 2
  end

  it 'should limit the number of hotlist bookmark results' do
    mock_req = double('http request')
    mock_req.should_receive(:body) { delicious_json }
    uri = URI.parse("#{delicious_url}?count=50")
    Net::HTTP.should_receive(:get_response).with(uri) { mock_req }

    get '/api/v1/delicious/feed?count=50'
    last_response.should be_ok
  end

  it 'should ignore empty count parameters' do
    mock_req = double('http request')
    mock_req.should_receive(:body) { delicious_json }
    uri = URI.parse("#{delicious_url}")
    Net::HTTP.should_receive(:get_response).with(uri) { mock_req }

    get '/api/v1/delicious/feed?count='
    last_response.should be_ok
  end

  it "should ignore the count param if it's not a positive integer" do
    mock_req = double('http request')
    mock_req.should_receive(:body) { delicious_json }
    uri = URI.parse("#{delicious_url}")
    Net::HTTP.should_receive(:get_response).with(uri) { mock_req }

    get '/api/v1/delicious/feed?count=-100'
    last_response.should be_ok
  end

  it 'should return 404 when page cannot be found' do
    get '/404'
    last_response.status.should == 404
  end
end
