require_relative 'spec_helper'
require_relative 'delicious_context.rb'

describe 'The Delicious App' do
  include_context 'delicious context'

  describe '#/ - homepage' do
    before do
      get '/'
      @last_response = last_response
    end

    it { @last_response.should be_ok }

    it 'includes "Discover interesting websites" in the body' do
      @last_response.body.should include('Discover interesting websites')
    end

    it 'has a text/html content type' do
      @last_response.headers['Content-Type'].should include('text/html')
    end
  end

  describe '#/api/v1/delicious/feed - hotlist bookmarks' do
    context 'when count is not specified' do
      before do
        mock_get_json URI.parse(@delicious_url)
        get '/api/v1/delicious/feed'
        @last_response = last_response
      end

      it { @last_response.should be_ok }

      it 'has an application/json content type' do
        @last_response.headers['Content-Type'].should == 'application/json'
      end

      it 'returns json from delicious' do
        @last_response.body.should == delicious_json
      end

      it 'returns two bookmarks' do
        JSON.parse(@last_response.body).length.should == 2
      end
    end

    context 'when count is a number' do
      before do
        mock_get_json URI.parse("#{@delicious_url}?count=50")
        get '/api/v1/delicious/feed?count=50'
        @last_response = last_response
      end

      it 'adds a count parameter to the delicious request' do
        @last_response.should be_ok
      end
    end

    context 'when count is a negative number' do
      before do
        mock_get_json URI.parse("#{@delicious_url}")
        get '/api/v1/delicious/feed?count=-100'
        @last_response = last_response
      end

      it 'ignores the count parameter in the delicious request' do
        @last_response.should be_ok
      end
    end
  end

  describe '#/api/v1/delicious/feeds/recent - recent bookmarks' do
    context 'when count is not specified' do
      before do
        mock_get_json URI.parse("#{@delicious_url}/recent")
        get '/api/v1/delicious/feed/recent'
        @last_response = last_response
      end

      it { @last_response.should be_ok }

      it 'has an application/json content type' do
        @last_response.headers['Content-Type'].should == 'application/json'
      end

      it 'returns json from delicious' do
        @last_response.body.should == delicious_json
      end

      it 'returns two bookmarks' do
        JSON.parse(@last_response.body).length.should == 2
      end
    end

    context 'when count is a number' do
      before do
        mock_get_json URI.parse("#{@delicious_url}/recent?count=50")
        get '/api/v1/delicious/feed/recent?count=50'
        @last_response = last_response
      end

      it 'adds a count parameter to the delicious request' do
        @last_response.should be_ok
      end
    end
  end

  context 'when page cannot be found' do
    before do
      get '/404'
      @last_response = last_response
    end

    it 'returns 404' do
      last_response.status.should == 404
    end
  end
end
