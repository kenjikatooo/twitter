require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name:"Example User", email:"example@unko.com", 
      password:"iamunko", password_confirmation:"iamunko")
  end

  test "user should be valid" do
      assert @user.valid?
  end

  test "name should be valid" do
    #０文字を許さないという方針
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    #51文字以上の名前を書くとエラーにする
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    #@の前のに241文字以上書いてある場合はエラーにする
    @user.email = "a"*241 + "@example.com"
    assert_not @user.valid?
  end

  test "メールアドレスとして正しいか" do
    #考えられるパターンをサンプルとして正しいものとして加えてテスト
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      #どのメールアドレスで成功したかを特定するためにinspectで引っ張ってくる
      assert @user.valid?, "#{valid_address.inspect} は有効です"
    end
  end

  test "正しくないメールアドレスにエラーを出す" do
    #,を使っている、@がない、.で終わる、_や+が入ってるのはアウト
    invalid_addresses = %w[user@example,com user_atfooooo user.name@example. foo@bar_baz.com foo@foo+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} は無効です"
    end
  end

  test "メールアドレスの一意性をテスト" do
    #dupは同じ属性を持つデータを複製するメソッド
    duplicate_user = @user.dup
    #メールは大文字小文字が区別されないために、わざと大文字もエラーになるようにする
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "メールアドレスが小文字で保存するbefore_saveアクションをテスト" do
    #大文字小文字が混ざったメールアドレスを設定し保存する
    mixed_case_email = "Unko@exAlE.Com"
    @user.email = mixed_case_email
    @user.save
    #保存されたメールとmixedのdowncaseが一緒かどうかを比較
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "パスワードが記入されているかどうかテスト" do
    #ない場合をアウトにする
    @user.password = @user.password_confirmation = " "*6
    assert_not @user.valid?
  end

  test "パスワードが最低限の長さであることをテスト" do
    @user.password = "a"*5
    assert_not @user.valid?
  end

  test "authenticated?メソッドがnil digestの時にfalseを返すか" do
    assert_not @user.authenticated?('')
  end
end
