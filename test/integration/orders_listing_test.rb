require 'test_helper'
require 'pry'

class OrdersListingTest < ActionDispatch::IntegrationTest
  fixtures :all

  def setup
    host! 'api.example.com'
  end

  test 'return a list of orders' do
    get 'api/orders'
    assert_equal 200, response.status
    orders = json(response.body)
    names = orders.collect { |order| order[:name] }
    assert_includes names, 'Order 1'
    assert_includes names, 'Order 2'
    refute_empty response.body
  end

  test 'return orders filtered by pay type' do
    get 'api/orders?pay_type=Check'
    assert_equal 200, response.status
    orders = json(response.body)
    names = orders.collect { |order| order[:name] }
    assert_includes names, 'Order 1'
  end
end
