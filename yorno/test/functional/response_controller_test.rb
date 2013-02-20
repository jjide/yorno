require 'test_helper'

class ResponseControllerTest < ActionController::TestCase
  test "should get yes" do
    get :yes
    assert_response :success
  end

  test "should get no" do
    get :no
    assert_response :success
  end

  test "should get count" do
    get :count
    assert_response :success
  end

end
