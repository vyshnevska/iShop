Rails.application.routes.draw do
  resources :orders

  resources :carts
  resources :cart_items
  resources :products

  get 'store/index'

  root to: 'store#index', as: 'store'
end
