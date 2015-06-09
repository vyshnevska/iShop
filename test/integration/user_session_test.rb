require 'test_helper'

class UserSessionTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @user1 = users(:user1)
    @pw = 'user1_pw'
  end

  test "user should not sign in with invalid password" do
    post user_session_path, :user => { :email => @user1.email, :password => 'bad_adm_PW'}
    assert_equal flash[:alert], 'Invalid email or password.', 'Administrator authentication succeed with a bad password.'
  end

  test "user should sign in with a valid password" do
    post_via_redirect user_session_path, :user => { :email => @user1.email, :password => @pw}
    assert_equal flash[:notice], 'Signed in successfully.', 'Administrator authentication failed with a good password.'
  end
end
