module Api
  module V1
    class GeolocationValuesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_geolocation, only: [:show, :destroy]
      before_action :initialize_geolocation_service, only: [:create]

      # POST /api/v1/geolocation_values
      def create
        puts "Entrando"
        data = @geolocation_service.fetch_data(params[:ip_or_url])
        if data
          # Procesar los datos y crear el objeto GeolocationValue
          @geolocation = GeolocationValue.new(
            ip: data['ip'], 
            data: data, 
            web: params[:ip_or_url]
          )
          if @geolocation.save
            render json: @geolocation, status: :created
          else
            render json: @geolocation.errors, status: :unprocessable_entity
          end
        else
          render json: { error: 'Error fetching geolocation data' }, status: :unprocessable_entity
        end
      end

      # GET /api/v1/geolocation_values/:ip_or_url
      def show
        if @geolocation
          render json: @geolocation
        else
          render json: { error: 'Geolocation not found' }, status: :not_found
        end
      end

      # DELETE /api/v1/geolocation_values/:ip_or_url
      def destroy
        if @geolocation
          @geolocation.destroy
          head :no_content
        else
          render json: { error: 'Geolocation not found' }, status: :not_found
        end
      end

      private
      
      # Use before_action to find the geolocation
      def set_geolocation
        @geolocation = GeolocationValue.find_by(ip: params[:ip_or_url]) || GeolocationValue.find_by(web: params[:ip_or_url])
      end

      def initialize_geolocation_service
        @geolocation_service = GeolocationValueService.new
      end
    end
  end
end
