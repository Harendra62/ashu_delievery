Rails.application.routes.draw do
  devise_for :users do
    get "users/sign_out" => "devise/sessions#destroy" 
  end
  root "categories#index" 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :categories do
    resources :products, only: [:show]
  end
  post 'add', to: 'carts#add_item', as: 'add_to_cart'
  put 'carts/:id', to: 'carts#update', as: 'update_cart'
  delete 'carts/:id', to: 'carts#remove_item', as: 'remove_from_cart'
  resources :carts
  resources :payments, only: [] do
    collection do
      post :create_checkout_session
      get :success
      get :cancel
    end
  end
  resources :orders
end
