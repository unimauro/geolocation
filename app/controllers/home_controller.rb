class HomeController < ApplicationController
  def status
    render plain: "Servicios OK"
  end
end
