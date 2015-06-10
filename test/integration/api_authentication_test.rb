require 'test_helper'

class ApiAuthenticationTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.localhost.com'
    @user = User.create!( email: 'api_user@ishop.com',
                          password: '1q2w3e4r',
                          password_confirmation: '1q2w3e4r')
  end

  test 'valid authentication using the api version 2' do
    get 'api/v2/orders', {}, { 'Authorization' => token_header(@user.auth_token)}
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
