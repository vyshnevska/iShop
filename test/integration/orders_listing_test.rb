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
    assert_equal Mime::JSON, response.content_type
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

  test 'return first order' do
    get 'api/orders/'+ Order.first.id.to_s
    assert_equal 200, response.status
    assert_equal response.body, Order.first.to_json
  end

  test 'creating a new order with Check pay type' do
    post 'api/orders', { order: { name: 'Test Order',
                                  address: 'San Francisco, 4214 Nydalen',
                                  email: 'test@ishop.com',
                                  pay_type: 'Check'}
                        }
    { 'Accept' => 'Mime::JSON', 'Content-Type' => Mime::JSON.to_s}

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    order = json(response.body)
    assert_equal (order[:name]), 'Test Order'
  end
end
