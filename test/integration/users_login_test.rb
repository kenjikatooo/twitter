require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:graham)
  end

  test "login with invalid information" do
    get login_path
    #sessionsコントローラークラスのnew.htmlが開かれてるかどうかをテスト
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  #ログアウトのテストは、ログインした状態の延長にあるのでログインのテストと同時に行う
  test "正常にログインできたかどうか&ログイン後ログアウトできたかどうか" do
    get login_path
    #ユーザーのデータを持ってきて
    post login_path, params: { session: { email: @user.email, 
    password: 'password'} }
    #ログインされたかどうかをまずはテスト
    assert is_logged_in?
    #ユーザーのページが表示されるかどうかをテスト
    assert_redirected_to @user
    follow_redirect!
    #ユーザーページ（show.html）と一緒かどうか
    assert_template 'users/show'
    #ログインのリンクがなくて
    assert_select "a[href=?]", login_path, count: 0
    #ログアウトのリンクがあるかどうか
    assert_select "a[href=?]", logout_path
    #ホームを押したらユーザーの画面に戻るかどうか
    assert_select "a[href=?]", user_path(@user)
    #ログアウトする
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    #２番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path
    follow_redirect!
    #ログインできるかどうか
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "remember_meを使ってログインできるかどうか" do
    log_in_as(@user, remember_me: '1')
    #remember_tokenが保存されているかどうか
    assert_not_empty cookies['remember_token']
  end

  test "remember_meなしでログイン" do
    #クッキーを保存してログイン
    log_in_as(@user, remember_me:'1')
    delete logout_path
    #クッキーを削除してログイン
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end

