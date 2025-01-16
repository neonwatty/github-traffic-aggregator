require "test_helper"

class ReposControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get repos_index_url
    assert_response :success
  end

  test "should get show" do
    get repos_show_url
    assert_response :success
  end
end
