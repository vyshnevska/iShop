Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :orders

  resources :carts, except: [:edit, :new]
  resources :cart_items, only: :create
  resources :products do
    get :buyer, on: :member
  end

  resources :store, only: :index

  root to: 'store#index', as: 'store'

  namespace :api do
    resources :orders

    namespace :v1 do
      resources :orders
    end

    namespace :v2 do
      resources :orders
    end
    get '*path' => redirect('/')
  end

  mount RolloutUi::Engine => "/rollout"

  get '*path' => redirect('/')
end
