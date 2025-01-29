require "test_helper"

class SeachesControllerTest < ActionDispatch::IntegrationTest
  test "should get seach" do
    get seaches_seach_url
    assert_response :success
  end
end
