require 'test_helper'

class CartItemsControllerTest < ActionController::TestCase
  setup do
    @cart_item = cart_items(:one)
  end

  test "should create cart_item" do
    assert_difference('CartItem.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to cart_item_path(assigns(:cart_item).cart)
  end
end
