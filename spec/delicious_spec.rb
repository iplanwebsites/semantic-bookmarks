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
        mock_get_json @delicious_url
        get '/api/v1/delicious/feed'
        @last_response = last_response
      end

      it 'queries delicious for hotlist bookmarks' do
        @last_response.should be_ok
      end

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
        mock_get_json "#{@delicious_url}?count=50"
        get '/api/v1/delicious/feed?count=50'
        @last_response = last_response
      end

      it 'adds a count parameter to the delicious request' do
        @last_response.should be_ok
      end
    end

    context 'when count is a negative number' do
      before do
        mock_get_json "#{@delicious_url}"
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
        mock_get_json "#{@delicious_url}/recent"
        get '/api/v1/delicious/feed/recent'
        @last_response = last_response
      end

      it 'queries delicious for recent bookmarks' do
        @last_response.should be_ok
      end

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
        mock_get_json "#{@delicious_url}/recent?count=50"
        get '/api/v1/delicious/feed/recent?count=50'
        @last_response = last_response
      end

      it 'adds a count parameter to the delicious request' do
        @last_response.should be_ok
      end
    end
  end

  describe '#/api/v1/delicious/feed/tag - bookmarks by tag' do
    context 'when count is not specified' do
      before do
        mock_get_json "#{@delicious_url}/tag/javascript"
        get '/api/v1/delicious/feed/tag/javascript'
        @last_response = last_response
      end

      it 'queries delicious for bookmarks by tag' do
        @last_response.should be_ok
      end

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
        mock_get_json "#{@delicious_url}/tag/javascript?count=50"
        get '/api/v1/delicious/feed/tag/javascript?count=50'
        @last_response = last_response
      end

      it 'adds a count parameter to the delicious request' do
        @last_response.should be_ok
      end
    end

    context 'when multiple tags are specified' do
      before do
        mock_get_json "#{@delicious_url}/tag/tag1+tag2+tag3"
        get '/api/v1/delicious/feed/tag/tag1+tag2+tag3'
        @last_response = last_response
      end

      it 'queries delicious for an intersection of tags' do
        @last_response.should be_ok
      end
    end
  end

  describe '#/api/v1/delicious/feed/popular - popular bookmarks' do
    context 'when count is not specified' do
      before do
        mock_get_json "#{@delicious_url}/popular"
        get '/api/v1/delicious/feed/popular'
        @last_response = last_response
      end

      it 'queries delicious for popular bookmarks' do
        last_response.should be_ok
      end

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
        mock_get_json "#{@delicious_url}/popular?count=80"
        get '/api/v1/delicious/feed/popular?count=80'
        @last_response = last_response
      end

      it 'adds a count parameter to the delicious request' do
        @last_response.should be_ok
      end
    end
  end

  describe '#/api/v1/delicious/feed/popular/tag - popular bookmarks by tag' do
    context 'when count is not specified' do
      before do
        mock_get_json "#{@delicious_url}/popular/scala"
        get '/api/v1/delicious/feed/popular/scala'
        @last_response = last_response
      end

      it 'queries delicious for popular bookmarks by tag' do
        last_response.should be_ok
      end

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
        mock_get_json "#{@delicious_url}/popular/scala?count=80"
        get '/api/v1/delicious/feed/popular/scala?count=80'
        @last_response = last_response
      end

      it 'adds a count parameter to the delicious request' do
        @last_response.should be_ok
      end
    end
  end

  describe "#/api/v1/delicious/feed/username - user's public bookmarks" do
    context 'when count is not specified' do
      before do
        mock_get_json "#{@delicious_url}/antirez"
        get '/api/v1/delicious/feed/antirez'
        @last_response = last_response
      end

      it "queries delicious for user's public bookmarks" do
        last_response.should be_ok
      end

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
        mock_get_json "#{@delicious_url}/antirez?count=80"
        get '/api/v1/delicious/feed/antirez?count=80'
        @last_response = last_response
      end

      it 'adds a count parameter to the delicious request' do
        @last_response.should be_ok
      end
    end
  end

  describe "#/api/v1/delicious/feed/username - user's public bookmarks by tag" do
    context 'when count is not specified' do
      before do
        mock_get_json "#{@delicious_url}/antirez/redis"
        get '/api/v1/delicious/feed/antirez/redis'
        @last_response = last_response
      end

      it "queries delicious for user's public bookmarks by tag" do
        last_response.should be_ok
      end

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
        mock_get_json "#{@delicious_url}/antirez/redis?count=80"
        get '/api/v1/delicious/feed/antirez/redis?count=80'
        @last_response = last_response
      end

      it 'adds a count parameter to the delicious request' do
        @last_response.should be_ok
      end
    end

    context 'when multiple tags are specified' do
      before do
        mock_get_json "#{@delicious_url}/antirez/redis+pub+sub"
        get '/api/v1/delicious/feed/antirez/redis+pub+sub'
        @last_response = last_response
      end

      it 'queries delicious for an intersection of tags' do
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
