Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home',to:'pages#home'
  resources :recipes
  get'signup',to:'chefs#new'
  resources :chefs,except:[:new]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout',to:'sessions#destroy'
  resources :ingredients, except: [:destroy]
  resources :recipes do
    resources :comments, only: [:create]
  end
  get '/chat', to: 'chatrooms#show'
  resources :messages, only: [:create]
  # mount ActionCable.server => '/cable'
  # get '/chat', to: 'chatrooms#show'
  # resources :messages, only: [:create]


  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
end
