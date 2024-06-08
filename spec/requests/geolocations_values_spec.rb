require 'rails_helper'

RSpec.describe "GeolocationsValues", type: :request do
  describe "GET /index" do
    it "returns a successful response" do
      get "/api/v1/geolocation_values"
      expect(response).to have_http_status(:success)
    end
  end
end
