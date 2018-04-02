require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    #ホームの画面がapp.html, home.htmlと一致しているかどうかのテスト
    assert_template 'static_pages/home'
    #ホームにいくリンクが2つあるかどうか
    assert_select "a[href=?]", root_path, count: 2
    #同様にhelpページなどへのパスがあるかどうか
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end
end
