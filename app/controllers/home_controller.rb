class HomeController < ApplicationController
  def status
    render json: { status: 'OK' }, status: :ok
  end
end
