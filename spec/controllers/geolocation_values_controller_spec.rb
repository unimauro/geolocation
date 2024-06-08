require 'rails_helper'

RSpec.describe GeolocationsController, type: :controller do
  let(:valid_attributes) { { ip_or_url: '134.201.250.155' } }
  let(:invalid_attributes) { { ip_or_url: 'invalid' } }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Geolocation' do
        expect {
          post :create, params: valid_attributes
        }.to change(Geolocation, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'returns a bad request status' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
