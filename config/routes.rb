Rails.application.routes.draw do
  get 'password_resets/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'

  # Posts
  resources :posts do 
    collection do
      post :import
      get :import
      get :upload
      post :post_form
      get :post_form, to: "posts#new"
      post :create_confirm
      get :create_confirm
      get :search_post
    end
    member do
      patch :post_edit_form
      get :update_confirm
      post :post_update
      get :pop_up
    end
  end
  
  # Users
  resources :users do
    collection do
      post :create_confirm
      get :create_confirm, to: "users#new"
      get :search_user
    end
    member do
      get :profile
      get :edit_profile
      patch :update_profile
      get :change_password
      post :update_password
      get :update_password
    end
  end
  resources :password_resets

  get '/login' => 'sessions#login'
  post '/login' => 'sessions#create'
  delete "/session", to: "sessions#destroy"
  get '/sign_up' => 'sessions#sign_up'
  post '/create_account' => 'sessions#create_account'
  get '/create_account' => 'sessions#sign_up'
end
