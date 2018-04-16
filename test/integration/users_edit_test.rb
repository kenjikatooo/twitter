require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    #基本的なユーザーの定義
    @user = users(:graham)
  end

  test "編集の失敗" do
    log_in_as(@user)
    #該当ユーザーの編集ページを開く
    get edit_user_path(@user)
    #edit.html.erbと一緒かどうかをテスト
    assert_template 'users/edit'
    #間違ったユーザー情報を入力する
    #patchメソッドで部分的にユーザーの情報を取ってきて、送信する
    patch user_path(@user), params: { user: { name: "", 
      email: "foo@invalid", 
      password: "foo", 
      password_confirmation: "bar" } }
    assert_template 'users/edit'
  end

  test "編集の成功withフレンドリーフォワーディング" do
    #最初に編集のurlを要求する
    get edit_user_path(@user)
    #まずテストユーザーでログインする→beforeアクションを乗り越える
    log_in_as(@user)
    #ログインしたら編集画面に戻るようにする
    assert_redirected_to edit_user_path(@user)
    #変えたいユーザーの情報を追加で入力する
    #パスワードは入力しなくても更新できるようにする
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name, 
      email: email, 
      password: '', 
      password_confirmation: '' } }
    assert_not flash.empty?
    #ユーザーのページに戻る
    #ここは@userとしているが、user_path(@user)でも良い
    assert_redirected_to @user
    #データベースを更新してユーザー情報が更新されたかどうかを確認
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

end
