module Api
  module V1
    class GeolocationValuesController < ApplicationController
      before_action :set_geolocation, only: [:show, :destroy]

      # POST /api/v1/geolocation_values
      def create
        @geolocation = Geolocation.new(geolocation_params)

        if @geolocation.save
          render json: @geolocation, status: :created
        else
          render json: @geolocation.errors, status: :unprocessable_entity
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

      # Use strong parameters for security
      def geolocation_params
        params.require(:geolocation).permit(:ip, :url)
      end

      # Use before_action to find the geolocation
      def set_geolocation
        @geolocation = Geolocation.find_by(ip: params[:ip_or_url]) || Geolocation.find_by(url: params[:ip_or_url])
      end
    end
  end
end
