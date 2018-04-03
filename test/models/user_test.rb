require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name:"Example User", email:"example@unko.com")
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
end
