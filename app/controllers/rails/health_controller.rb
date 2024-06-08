# app/controllers/rails/health_controller.rb
class Rails::HealthController < ApplicationController
  def show
    render json: { status: 'OK' }, status: :ok
  end
end
