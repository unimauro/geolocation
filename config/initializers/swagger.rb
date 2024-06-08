# config/initializers/swagger.rb
if Rails.env.development? && defined?(Swagger::Blocks)
  Swagger::Blocks.setup do |config|
    config.base_path = '/api/v1'
    config.camelize_model_properties = false
  end  
end
