require 'httparty'

class GeolocationValueService
  def initialize
    @api_key = ENV['IPSTACK_API_KEY']
    @url_api = ENV['URL_API']
  end

  def fetch_data(ip_or_url)
    response = HTTParty.get("http://#{@url_api}/#{ip_or_url}?access_key=#{@api_key}")
    if response.success?
      response.parsed_response
    else
      nil
    end
  end
end
