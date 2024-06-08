require 'httparty'

class GeolocationValueService
  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_data(ip_or_url)
    response = HTTParty.get("http://api.ipstack.com/#{ip_or_url}?access_key=#{@api_key}")
    if response.success?
      response.parsed_response
    else
      nil
    end
  end
end
