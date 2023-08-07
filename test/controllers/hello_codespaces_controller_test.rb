require "test_helper"

class HelloCodespacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get "/api/v1/"
    assert_response :success
  end
end
