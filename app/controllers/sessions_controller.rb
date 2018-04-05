class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #redirect_to users_path
    else
      #他の画面に行った時にフラッシュが消えるように.nowをつける
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています'
      #new.htmlのビューに返るようにする
      render 'new'
    end
  end

  def destroy
  end
end
