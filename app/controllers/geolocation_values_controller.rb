class GeolocationValuesController < ApplicationController
  include Swagger::Blocks
  before_action :set_geolocation, only: [:show, :destroy]

  swagger_path '/geolocation_values' do
    operation :post do
      key :summary, 'Create a geolocation'
      key :description, 'Creates a new geolocation record based on IP address or URL'
      key :operationId, 'createGeolocation'
      key :produces, ['application/json']
      key :tags, ['Geolocations']

      parameter name: :ip_or_url, in: :body, schema: { type: :string }, required: true

      response 201 do
        key :description, 'Geolocation created successfully'
        schema do
          key :'$ref', :Geolocation
        end
      end

      response 422 do
        key :description, 'Unprocessable entity'
        schema do
          key :'$ref', :Errors
        end
      end

      response 400 do
        key :description, 'Bad request'
        schema do
          key :'$ref', :Error
        end
      end
    end
  end

  swagger_path '/geolocation_values/{ip_or_url}' do
    operation :get do
      key :summary, 'Get geolocation by IP address or URL'
      key :description, 'Returns a single geolocation record'
      key :operationId, 'findGeolocation'
      key :produces, ['application/json']
      key :tags, ['Geolocations']

      parameter name: :ip_or_url, in: :path, required: true, type: :string

      response 200 do
        key :description, 'Geolocation response'
        schema do
          key :'$ref', :Geolocation
        end
      end
    end

    operation :delete do
      key :summary, 'Delete geolocation by IP address or URL'
      key :description, 'Deletes a geolocation record'
      key :operationId, 'deleteGeolocation'
      key :produces, ['application/json']
      key :tags, ['Geolocations']

      parameter name: :ip_or_url, in: :path, required: true, type: :string

      response 204 do
        key :description, 'No content'
      end
    end
  end

  private

  def set_geolocation
    @geolocation = Geolocation.find_by(ip: params[:ip_or_url]) || Geolocation.find_by(url: params[:ip_or_url])
  end

  def geolocation_params
    params.require(:geolocation).permit(:ip, :url)
  end
end