require 'rails_helper'

RSpec.describe GeolocationsValuesHelper, type: :helper do
  describe '#format_geolocation' do
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