module GeolocationsValuesHelper
  def format_geolocation(geolocation)
    return 'Unknown' if geolocation.nil?

    if geolocation.ip?
      "IP: #{geolocation.ip}"
    elsif geolocation.web?
      "WEB: #{geolocation.web}"
    else
      'Unknown'
    end
  end
end
