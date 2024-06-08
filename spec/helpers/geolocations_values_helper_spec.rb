require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the GeolocationsValuesHelper. For example:
#
# describe GeolocationsValuesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe GeolocationsValuesHelper, type: :helper do
  describe '#format_geolocation' do
    it 'returns formatted geolocation string for IP' do
      geolocation = Geolocation.new(ip: '134.201.250.155')
      expect(helper.format_geolocation(geolocation)).to eq('IP: 134.201.250.155')
    end

    it 'returns formatted geolocation string for URL' do
      geolocation = Geolocation.new(url: 'example.com')
      expect(helper.format_geolocation(geolocation)).to eq('URL: example.com')
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