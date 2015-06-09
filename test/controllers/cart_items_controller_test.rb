require 'test_helper'

class CartItemsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:user1)
    @cart_item = cart_items(:one)
  end

  test "should create cart_item" do
    assert_difference('CartItem.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to store_url(assigns(:cart_item).cart)
  end
end
