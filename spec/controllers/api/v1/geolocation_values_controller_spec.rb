require 'rails_helper'

RSpec.describe Api::V1::GeolocationValuesController, type: :controller do
  let(:valid_attributes) { { ip_or_url: '134.201.250.155' } }
  let(:invalid_attributes) { { ip_or_url: 'invalid' } }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new GeolocationValue' do
        expect {
          post :create, params: valid_attributes
        }.to change { GeolocationValue.count }.by(1)
      end
    end

    context 'with invalid params' do
      it 'returns a bad request status' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    let!(:geolocation) { GeolocationValue.create(ip: '134.201.250.155',web: '134.201.250.155') }

    context 'when geolocation exists' do
      it 'returns the geolocation' do
        get :show, params: { ip_or_url: geolocation.ip }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when geolocation does not exist' do
      it 'returns a not found status' do
        get :show, params: { ip_or_url: 'non_existent_ip' }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Geolocation not found')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:geolocation) { GeolocationValue.create(ip: '134.201.250.155',web: '134.201.250.155') }

    context 'when geolocation value exists' do
      it 'deletes the geolocation value' do
        expect {
          delete :destroy, params: { ip_or_url: geolocation.ip }
        }.to change { GeolocationValue.count }.by(-1)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when geolocation does not exist' do
      it 'returns a not found status' do
        delete :destroy, params: { ip_or_url: 'non_existent_ip' }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Geolocation not found')
      end
    end
  end
end
