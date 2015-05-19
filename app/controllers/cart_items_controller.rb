class CartItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @cart_item = @cart.add_product(product.id)

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to store_url }
        format.json { render :show, status: :created, location: @cart_item }
      else
        format.html { render :new }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end
end
