require_relative 'spec_helper'

url = 'http://feeds.delicious.com/v2/json'

describe 'The Sinatra Helpers' do

  it 'should parse and fetch a URL' do
    mock_req = double('http request')
    Net::HTTP.should_receive(:get_response).with(URI.parse(url)) { mock_req }

    response = get_url(url)
    response.should == mock_req
  end

  it 'should fetch a URL and return the parsed JSON' do
    mock_req = double('http request')
    mock_req.should_receive(:body) { '{ "mamma": "mia" }' }
    Net::HTTP.should_receive(:get_response).with(URI.parse(url)) { mock_req }

    response = get_json(url)
    response['mamma'].should == 'mia'
  end

  it 'should raise an error if the response is not valid JSON' do
    mock_req = double('http request')
    mock_req.should_receive(:body) { '<html></html>' }
    Net::HTTP.should_receive(:get_response).with(URI.parse(url)) { mock_req }

    expect { get_json(url) }.to raise_error(JSON::ParserError)
  end

  it 'should return the count as a URL query param' do
    count_param(20).should == '?count=20'
  end

  it 'should return nil if the count is empty' do
    count_param('').should == nil
    count_param(nil).should == nil
  end

  it 'should return nil for non integer params' do
    count_param('bla'.should) == nil
  end

  it 'should return nil for negative integers' do
    count_param('-10') == nil
  end

end
