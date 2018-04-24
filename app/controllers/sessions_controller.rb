class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #さらにアカウントの有効化チェックをする
      if user.activated?
        #sessions_helperで定められたlog_in メソッドを使ってuserにログインする
        log_in user
        #三項演算子っていうのを使って本当はif文でかけるところを１行で書いてしまってる
        # if params[:session][:remember_me] == '1'
        #  remember(user)
        # else
        #  forget(user)
        # end
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        #記憶したURLにリダイレクトする
        redirect_back_or user
      else
        #アカウントが有効化されてなかった場合
        message = "アカウントが有効化されていません。"
        message += "メールボックスを確認してください。"
        flash[:warning] = message
        redirect_to root_url
      end
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
