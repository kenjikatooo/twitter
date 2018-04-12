require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "無効なユーザー登録を防止する" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "", 
        email: "user@invalid", 
        password: "foo", 
        password_confirmation: "bar"}}
    end
    #new.htmlに返す
    assert_template 'users/new'
  end

  test "有効なユーザ登録をテスト" do
    get signup_path
    assert_difference 'User.count', 1 do
      #users_pathへpostする
      post users_path, params: { user: { name: "Example User", 
        email: "user@example.com", 
        password: "password", 
        password_confirmation: "password"}}
      end
      #リダイレクトするかどうか
      follow_redirect!
      #ユーザープロフィール画面へ移動
      assert_template 'users/show'
      #新規登録後ログインできているかどうかをテスト
      assert is_logged_in?
    end
end
