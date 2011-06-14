require 'json'
require 'net/http'

module Helpers
  def get_url(url)
    Net::HTTP.get_response(URI.parse(url))
  end

  def get_json(url)
    resp = get_url url
    JSON.parse resp.body
  end
end
