Rails.application.routes.draw do
  # Mount the Rswag API documentation at /api-docs
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs' if Rails.env.development? # Only for development environment

  # Define the API routes for login and signup
  namespace :api do 
    namespace :v1 do 
      post '/login', to: 'user#login'
      post '/signup', to: 'user#signup'
    end
  end
end
