module API
  class OrdersController < ApplicationController
    # Skip devise authentication. Generate custom user auth token
    skip_before_filter :authenticate_user!
    before_action :authenticate

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

    def create
      order = Order.create!(order_params)
      if order
        render json: order, status: :created
      else
        render json: order.errors, status: :unprocessable_entity
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Orders"'

      respond_to do |format|
        format.json { render json: 'Invalid credentials', status: 401 }
        format.xml { render xml: 'Invalid credentials', status: 401 }
      end
    end

    private
      def order_params
        params.require(:order).permit(:name, :address, :email, :pay_type)
      end

    protected

      def authenticate
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        authenticate_with_http_token do |token, options|
          User.find_by(auth_token: token)
        end
      end
  end
end
