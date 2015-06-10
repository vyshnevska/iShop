module API
  class V2::OrdersController < ApplicationController
    # Skip devise authentication. Generate custom user auth token
    skip_before_filter :authenticate_user!
    before_action :authenticate

    def index
      orders = Order.all
      render json: orders, status: :ok
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Orders"'

      respond_to do |format|
        format.json { render json: 'Invalid credentials', status: 401 }
        format.xml { render xml: 'Invalid credentials', status: 401 }
      end
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
