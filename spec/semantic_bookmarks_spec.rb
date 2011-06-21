require_relative 'spec_helper'

describe 'The Semantic Bookmarks App' do

  def app
    @app ||= SemanticBookmarksApp
  end

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

end
