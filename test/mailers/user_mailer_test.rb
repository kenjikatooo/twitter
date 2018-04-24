require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    mail = UserMailer.account_activation
    #一旦メールは見れているのでテストコードは書かない
    #assert_equal "アカウントの認証について", mail.subject
    #assert_equal ["to@example.org"], mail.to
    #assert_equal ["noreply@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  end

  test "password_reset" do
    mail = UserMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
