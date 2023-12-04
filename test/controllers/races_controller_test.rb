require "test_helper"
class RacesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "when the user is not logged in it redirect to the sign in page" do
    get races_url
    assert_redirected_to new_user_session_url
  end
  test "when the user is logged it works successfully" do
    sign_in users(:user_1)
    get races_url
    assert_response :success
  end
end
