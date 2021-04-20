Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'

  # Posts
  resources :posts do 
    collection do
      post :import
      get :upload
    end
  end
  
  # Users
  resources :users do
    collection do
      post :create_confirm
      get :create_confirm
    end
  end

  get '/login' => 'sessions#login'
  post '/login' => 'sessions#create'
end
