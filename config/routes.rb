Rails.application.routes.draw do
  root to: redirect('/api-docs')
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'


  
  namespace :api do 
    namespace :v1 do 
      post '/login', to: 'user#login'
      post '/signup', to: 'user#signup'
      get '/movies', to: 'movies#index'
      get '/movies/:id', to: 'movies#show'
      post '/movies', to: 'movies#create'
      post '/add_subscription', to:'subscription_plans#create'
      put '/update_plan/:id', to: 'subscription_plans#update'
      delete '/delete_plan/:id', to: 'subscription_plans#destroy'
      post '/buy_plan', to: 'subscription#create'
    end
  end
end
