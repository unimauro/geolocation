require 'rails_helper'

RSpec.describe "GeolocationsValues", type: :request do
  describe "GET /index" do
    it "returns a successful response" do
      # Aquí haces la petición GET a la ruta /index
      get api_v1_geolocation_values_path

      # Compruebas que la respuesta tenga el estado 200
      expect(response).to have_http_status(200)
    end
  end
end

