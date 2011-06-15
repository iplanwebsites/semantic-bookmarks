require_relative 'spec_helper'

describe 'The Sinatra Helpers' do
  let(:url) { 'http://feeds.delicious.com/v2/json' }

  describe '#get_url' do
    before do
      @mock_req = double('http request')
      Net::HTTP.should_receive(:get_response).with(URI.parse(url)) { @mock_req }
      @response = get_url(url)
    end

    it 'sends a GET request and returns an HTTPResponse object' do
      @response.should == @mock_req
    end
  end

  describe '#get_json' do
    context 'when the GET request returns valid JSON' do
      before do
        mock_req = double('http request')
        mock_req.should_receive(:body) { '{ "mamma": "mia" }' }
        Net::HTTP.should_receive(:get_response).with(URI.parse(url)) { mock_req }
        @response = get_json(url)
      end

      it 'returns the parsed JSON' do
        @response['mamma'].should == 'mia'
      end
    end

    context 'when the GET request returns invalid JSON' do
      before do
        mock_req = double('http request')
        mock_req.should_receive(:body) { '<html></html>' }
        Net::HTTP.should_receive(:get_response).with(URI.parse(url)) { mock_req }
      end

      it 'raises a ParserError' do
        expect { get_json(url) }.to raise_error(JSON::ParserError)
      end
    end
  end

  describe '#count_param' do
    context 'when the param is valid' do
      it 'returns the count as an URL query param' do
        count_param(20).should == '?count=20'
      end
    end

    context 'when the param is invalid' do
      it 'returns nil if the param is empty' do
        count_param('').should == nil
      end

      it 'returns nil if the param is nil' do
        count_param(nil).should == nil
      end

      it 'returns nil if the param is not an integer' do
        count_param('bla'.should) == nil
      end

      it 'returns nil if the param is a negative integer' do
        count_param('-10') == nil
      end
    end
  end

end
