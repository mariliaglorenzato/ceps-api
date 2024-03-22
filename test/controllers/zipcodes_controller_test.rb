require "test_helper"

class ZipcodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get zipcodes_index_url
    assert_response :success
  end
end
