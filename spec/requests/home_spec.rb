require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /status" do
    it "returns http success" do
      get "/status"
      follow_redirect! if response.status == 301
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("OK")
    end
  end
end
