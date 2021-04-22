Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'

  # Posts
  resources :posts do 
    collection do
      post :import
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
    end
  end

  get '/login' => 'sessions#login'
  post '/login' => 'sessions#create'
  delete "/session", to: "sessions#destroy"
end
