class ApplicationController < ActionController::Base #ActionController::API
  protect_from_forgery with: :exception
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  before_action :authenticate_user!
  before_action :set_session_cart

  private
    def set_session_cart
      @cart = current_cart
    end

    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
