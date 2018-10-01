require 'test_helper'

class CupboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cupboards_new_url
    assert_response :success
  end

  test "should get edit" do
    get cupboards_edit_url
    assert_response :success
  end

end
