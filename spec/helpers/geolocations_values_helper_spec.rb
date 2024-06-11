require 'rails_helper'

RSpec.describe GeolocationsValuesHelper, type: :helper do
  describe '#format_geolocation' do
    it 'returns formatted geolocation string for IP' do
      geolocation = Geolocation.create(ip: '134.201.250.155')
      expect(helper.format_geolocation(geolocation)).to eq('IP: 134.201.250.155')
    end

    it 'returns formatted geolocation string for URL' do
      geolocation = Geolocation.create(web: 'example.com')
      expect(helper.format_geolocation(geolocation)).to eq('WEB: example.com')
    end

    it 'handles nil geolocation' do
      expect(helper.format_geolocation(nil)).to eq('Unknown')
    end
  end

  describe '#display_error_message' do
    it 'returns formatted error message' do
      error_message = 'Geolocation not found'
      expect(helper.display_error_message(error_message)).to eq('Error: Geolocation not found')
    end
  end
end