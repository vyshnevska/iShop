class CartsController < ApplicationController
  before_action :set_cart, only: [:edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def index
    @carts = Cart.all
  end

  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to carts_path, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    session[:cart_id] = @cart.id

    respond_to do |format|
      format.html { redirect_to carts_path, notice: 'Cart is set as current successfully.' }
      format.json { render :show, status: :ok, location: @cart }
    end
  end

  def destroy
    session[:cart_id] = nil if session[:cart_id] == @cart.id
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: I18n.t('controllers.carts.empty') }
      format.json { head :no_content }
    end
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params[:cart]
    end

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, notice: 'Invalid cart'
    end
end
