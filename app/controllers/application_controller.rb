class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :authenticate_user!
  before_action :set_session_cart
  before_action :check_access_level, only: [:update, :delete, :create]

  private
    def set_session_cart
      @cart = current_cart
    end

    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.last || Cart.create
      session[:cart_id] = cart.id
      cart
    end

    def rollout?(name)
      $rollout.active? name, current_user
    end
    helper_method :rollout?

    def check_access_level
      if current_user
        unless rollout?(:editing)
          redirect_to store_path, flash: { error: I18n.t('controllers.main.access_not_allowed')}
        end
      else
        redirect_to new_user_session_path
      end
    end
end
