Rails.application.routes.draw do
  resources :events
#   resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/events', to: 'events#index'
  get '/events/:id', to: 'events#show'
  post '/events', to: 'events#create'
  put '/events', to: 'events#update'
  delete '/events/:id', to: 'events#destroy'
  post 'signup', to: 'users#create'
  get 'users', to: 'users#index'
  delete '/users/:id', to: 'users#destroy'
#   post 'login'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
