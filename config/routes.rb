Rails.application.routes.draw do
  devise_for :users
  resources :orders

  resources :carts, except: [:edit, :new]
  resources :cart_items, only: :create
  resources :products do
    get :buyer, on: :member
  end

  resources :store, only: :index

  root to: 'store#index', as: 'store'

  get '*path' => redirect('/')

  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    resources :orders
  end

end
