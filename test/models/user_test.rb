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
end
