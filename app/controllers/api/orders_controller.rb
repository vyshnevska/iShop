module API
  class OrdersController < ApplicationController
    acts_as_token_authentication_handler_for User, fallback_to_devise: false
    before_action :authenticate_user!

    def index
      orders = Order.all
      if pay_type = params[:pay_type]
        orders = orders.where(pay_type: pay_type)
      end
      render json: orders, status: :ok
    end

    def show
      order = Order.find(params[:id])
      render json: order, status: :ok
    end
  end
end
