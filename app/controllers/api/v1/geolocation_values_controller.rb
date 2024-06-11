module Api
  module V1
    class GeolocationValuesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_geolocation, only: [:show, :destroy]
      before_action :initialize_geolocation_service, only: [:create]

      # GET /api/v1/geolocation_values
      def index
        per_page = params[:per_page].present? ? params[:per_page].to_i : 10
        page = params[:page].present? ? params[:page].to_i : 1
        @geolocations = GeolocationValue.select(:ip, :web).page(page).per(per_page)
        #@geolocations = GeolocationValue.page(page).per(per_page)
        render json: @geolocations.map { |geo| { ip: geo.ip, web: geo.web } }
      end

      # POST /api/v1/geolocation_values
      def create
        @geolocation = GeolocationValue.unscoped.find_by(ip: params[:ip_or_url]) || GeolocationValue.unscoped.find_by(web: params[:ip_or_url])
        
        if @geolocation
          if @geolocation.deleted_at.present?
            @geolocation.update(deleted_at: nil)
            render json: @geolocation.data, status: :ok
          else
            render json: @geolocation.data, status: :ok
          end
        else
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
      end

      # GET /api/v1/geolocation_values/:ip_or_url
      def show
        @geolocation = GeolocationValue.find_by(ip: params[:ip_or_url]) || GeolocationValue.find_by(web: params[:ip_or_url])
        
        if @geolocation
          render json: @geolocation.data
        else
          render json: { error: 'Geolocation not found. Please use POST /api/v1/geolocation_values to add new data.' }, status: :not_found
        end
      end

      # DELETE /api/v1/geolocation_values/:ip_or_url
      def destroy
        if @geolocation
          @geolocation.soft_delete
          render json: { message: "OK: Deleted #{@geolocation.ip || @geolocation.web}" }, status: :ok
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
