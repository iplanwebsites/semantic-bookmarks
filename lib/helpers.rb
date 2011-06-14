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

  def count_param(count)
    if !count.to_s.empty? and count.to_s =~ /^\d+$/
      "?count=#{count}"
    end
  end
end
