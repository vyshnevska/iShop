# Store cart unique identifier in the session and keep a cart in the database
# So we can recover the identity from the session and use it to find the cart in the database.
module CurrentCart
  extend ActiveSupport::Concern

  private
    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
end
