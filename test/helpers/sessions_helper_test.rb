require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

    def setup
        @user = users(:graham)
        remember(@user)
    end

    test "セッションがない時にcurrent_userが正しいユーザーを返すか" do
        assert_equal @user, current_user
        assert is_logged_in?
    end

    test "remember_digestが違う時、current_userはnilを返すか" do
        @user.update_attribute(:remember_digest, User.digest(User.new_token))
        assert_nil current_user
    end

end