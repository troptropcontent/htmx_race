require "test_helper"

class RacesControllerTest < ActionDispatch::IntegrationTest
  test "when the user is not logged in" do
    test "it should redirect to sign in" do
      puts users
      get races_url
      assert_response :success
    end
  end
end
