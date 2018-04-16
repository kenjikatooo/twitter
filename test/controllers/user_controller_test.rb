require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:graham)
    #users.ymlよりもう一人のユーザーを引っ張ってくる
    @other_user = users(:chris)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "間違ったユーザーでログインした時に編集ができないようにできてるか" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "間違ったユーザーでログインし、他のユーザーのプロフをとってきて更新できる" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name, 
    email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
end
