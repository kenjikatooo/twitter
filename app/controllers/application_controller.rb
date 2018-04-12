class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def greeting
    render html: "twitterをつくろう"
  end
end
