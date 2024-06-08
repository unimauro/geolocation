class HomeController < ApplicationController
  def status
    render plain: "OK", status: :ok
  end
end
