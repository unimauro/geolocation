class GeolocationValuesController < ApplicationController
  before_action :set_geolocation, only: [:show, :destroy]

  def create
    @geolocation = Geolocation.new(geolocation_params)
    service = GeolocationService.new(ENV['IPSTACK_API_KEY'])
    data = service.fetch_data(params[:ip_or_url])

    if data
      @geolocation.assign_attributes(
        ip: params[:ip_or_url],
        latitude: data['latitude'],
        longitude: data['longitude'],
        city: data['city'],
        country: data['country_name']
      )

      if @geolocation.save
        render json: @geolocation, status: :created
      else
        render json: @geolocation.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unable to fetch geolocation data' }, status: :bad_request
    end
  end

  def show
    render json: @geolocation
  end

  def destroy
    @geolocation.destroy
    head :no_content
  end

  private

  def set_geolocation
    @geolocation = Geolocation.find_by(ip: params[:ip]) || Geolocation.find_by(url: params[:url])
  end

  def geolocation_params
    params.require(:geolocation).permit(:ip, :url)
  end
end
  