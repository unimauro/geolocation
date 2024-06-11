module GeolocationsValuesHelper
  def format_geolocation(geolocation)
    if geolocation.nil?
      'Unknown'
    elsif geolocation.ip?
      "IP: #{geolocation.ip}"
    elsif geolocation.web?
      "WEB: #{geolocation.web}"
    else
      'Unknown'
    end
  end
end
