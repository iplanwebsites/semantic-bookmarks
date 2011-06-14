require_relative 'spec_helper'

describe 'The Sinatra Helpers' do

  it 'should parse and fetch a URL' do
    url = 'http://feeds.delicious.com/v2/json'
    mock_req = double('http request')
    Net::HTTP.should_receive(:get_response).with(URI.parse(url)) { mock_req }

    response = get_url(url)
    response.should == mock_req
  end

  it 'should fetch a URL and parse the JSON reponse' do
    url = 'http://feeds.delicious.com/v2/json'
    mock_req = double('http request')
    mock_req.should_receive(:body) { '{ "mamma": "mia" }' }
    Net::HTTP.should_receive(:get_response).with(URI.parse(url)) { mock_req }

    response = get_json(url)
    response['mamma'].should == 'mia'
  end

end
