shared_context "delicious context", :a => :b do

  before { @delicious_url = 'http://feeds.delicious.com/v2/json' }

  let(:delicious_json) { %{[{"u":"http:\/\/vimeo.com\/24302498","d":"29 WAYS TO STAY CREATIVE on Vimeo","t":["video","creative","design","inspiration","creativity","via:packrati.us","criatividade","art","creatividad","dise\u00f1o"],"dt":"2011-06-04T03:36:20Z"},{"u":"http:\/\/scribblinlenore.livejournal.com\/559093.html","d":"In Plain Sight","t":["x-men","erik\/charles","charles\/erik","nc-17","author:scribblinlenore","fanfic","fic","au","scribblinlenore","xmen"],"dt":"2011-06-13T02:52:26Z"}]} }

  def mock_get_json(uri)
    mock_req = double('http request')
    mock_req.should_receive(:body) { delicious_json }
    Net::HTTP.should_receive(:get_response).with(uri) { mock_req }
    mock_req
  end
end
