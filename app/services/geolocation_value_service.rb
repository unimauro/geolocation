require 'httparty'

class GeolocationValueService
  def initialize
    @api_key = ENV['IPSTACK_API_KEY']
    @url_api = ENV['URL_API']
  end

  def fetch_data(ip_or_url)
    normalized_ip_or_url = normalize_url(ip_or_url)
    response = HTTParty.get("http://#{@url_api}/#{normalized_ip_or_url}")
    if response.success?
      response.parsed_response
    else
      nil
    end
  end

  private

  def normalize_url(ip_or_url)
    ip_or_url.sub(/^www\./, '') + "?access_key=#{@api_key}"
  end
end