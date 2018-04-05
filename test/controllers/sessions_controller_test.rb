require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    #login_pathとlogin_urlは同義
    get login_url
    assert_response :success
  end

end
