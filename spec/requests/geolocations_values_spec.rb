require 'rails_helper'

RSpec.describe "GeolocationsValues", type: :request do
  path '/api/v1/geolocation_values' do
    post 'Creates a geolocation value' do
      tags 'GeolocationValues'
      consumes 'application/json'
      parameter name: :geolocation_value, in: :body, schema: {
        type: :object,
        properties: {
          ip: { type: :string },
          data: { type: :string }
        },
        required: ['ip']
      }

    end
  end

  describe "GET /index" do
    it "returns a successful response" do
      get api_v1_geolocation_values_path

      expect(response).to have_http_status(200)
    end
  end
end

