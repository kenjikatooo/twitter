class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #sessions_helperで定められたlog_in メソッドを使ってuserにログインする
      log_in user
      #三項演算子っていうのを使って本当はif文でかけるところを１行で書いてしまってる
      # if params[:session][:remember_me] == '1'
      #  remember(user)
      # else
      #  forget(user)
      # end
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      remember user
      redirect_to user
    else
      #他の画面に行った時にフラッシュが消えるように.nowをつける
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています'
      #new.htmlのビューに返るようにする
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
