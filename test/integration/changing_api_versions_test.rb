require 'test_helper'

class ChangingApiVersionsTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  test 'api returns default version' do
    get '/api/orders'
    assert_equal 200, response.status
  end

  test 'api v1 returns ok status' do
    get '/api/v1/orders'
    assert_equal 200, response.status
  end

  test 'api v2 returns unauthorized status' do
    get '/api/v2/orders', format: :json
    assert_equal 401, response.status
    assert_equal "Invalid credentials", response.body
  end

end
