Rswag::Api.configure do |c|
  c.swagger_root = Rails.root.join('swagger').to_s
end

Rswag::Ui.configure do |c|
  c.swagger_endpoint '/api-docs/v1/swagger.yaml', 'API V1 Docs' if Rails.env.development?
end

Rswag::Specs.config do |c|
  c.swagger_root = Rails.root.join('swagger').to_s
  c.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        securitySchemes: {
          Bearer: {
            type: :http,
            scheme: :bearer,
            bearerFormat: 'JWT'
          }
        }
      }
    }
  }
  c.swagger_format = :yaml
end
