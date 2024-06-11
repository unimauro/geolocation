require 'swagger_helper'

RSpec.describe 'Geolocation Values API', type: :request do

  path '/api/v1/geolocation_values' do
    
    post 'Creates a geolocation value' do
      tags 'GeolocationValues'
      consumes 'application/json'
      parameter name: :geolocation, in: :body, schema: {
        type: :object,
        properties: {
          ip_or_url: { type: :string }
        },
        required: [ 'ip_or_url' ]
      }

      response '500', 'invalid request' do
        let(:geolocation) { { } }
        run_test!
      end
    end
  end

  path '/api/v1/geolocation_values/{ip_or_url}' do

    get 'Retrieves a geolocation value' do
      tags 'GeolocationValues'
      produces 'application/json'
      parameter name: :ip_or_url, in: :path, type: :string
      response '404', 'geolocation value not found' do
        let(:ip_or_url) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a geolocation value' do
      tags 'GeolocationValues'
      consumes 'application/json'
      parameter name: :ip_or_url, in: :path, type: :string
      parameter name: :geolocation, in: :body, schema: {
        type: :object,
        properties: {
          ip_or_url: { type: :string }
        },
        required: [ 'ip_or_url' ]
      }

      response '404', 'geolocation value updated' do
        let(:ip_or_url) { '8.8.8.8' }
        let(:geolocation) { { ip_or_url: '8.8.8.8' } }
        run_test!
      end

      response '404', 'invalid request' do
        let(:ip_or_url) { '8.8.8.8' }
        let(:geolocation) { { } }
        run_test!
      end

      response '404', 'geolocation value not found' do
        let(:ip_or_url) { 'invalid' }
        let(:geolocation) { { ip_or_url: '8.8.8.8' } }
        run_test!
      end
    end

    delete 'Deletes a geolocation value' do
      tags 'GeolocationValues'
      parameter name: :ip_or_url, in: :path, type: :string

      response '404', 'geolocation value deleted' do
        let(:ip_or_url) { '8.8.8.8' }
        run_test!
      end

      response '404', 'geolocation value not found' do
        let(:ip_or_url) { 'invalid' }
        run_test!
      end
    end
  end
end
