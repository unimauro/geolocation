# spec/support/swagger_helper.rb
require 'swagger_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  Rswag::Api.configure do |config|
    config.swagger_root = Rails.root.join('swagger').to_s
  end

  Rswag::Ui.configure do |config|
    config.swagger_endpoint '/api-docs/swagger.yaml', 'API V1 Docs'
  end
end

RSpec.describe 'Health API', type: :request do
  path '/up' do
    get 'Health check' do
      tags 'Health'
      produces 'application/json'

      response '200', 'Application is up and running' do
        schema type: :object,
               properties: {}
        run_test!
      end

      response '500', 'Application is not healthy' do
        run_test!
      end
    end
  end
end
