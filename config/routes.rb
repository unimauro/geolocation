Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  #validate
  namespace :api do
    namespace :v1 do
      resources :geolocation_values, only: [:index, :create, :update, :show, :destroy] do
        get ':ip_or_url', action: :show, on: :collection, constraints: { ip_or_url: /[^\/]+/ }
        put ':ip_or_url', action: :update, on: :collection, constraints: { ip_or_url: /[^\/]+/ }
        delete ':ip_or_url', action: :destroy, on: :collection, constraints: { ip_or_url: /[^\/]+/ }
      end
    end
  end
  
  #routes
  get 'status', to: 'home#status'

  # Defines the root path route ("/")
  # root "posts#index"
end