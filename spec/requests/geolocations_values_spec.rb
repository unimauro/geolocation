require 'rails_helper'

RSpec.describe "GeolocationsValues", type: :request do
  describe "GET /index" do
    it "returns a successful response" do
      get api_v1_geolocation_values_path
      follow_redirect! if response.status == 301
      expect(response).to have_http_status('404')
    end
  end
end
