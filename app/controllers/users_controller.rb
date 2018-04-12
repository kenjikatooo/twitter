class UsersController < ApplicationController
  def new
    #@userをこれから使っていくので変数として定義しておく
    @user = User.new
  end

  def show
    #@userを定義しshow.htmlに渡す
    @user = User.find(params[:id])
  end

  def create
    #User.new(name~~)とやってることは一緒でそれをparamsでやってる
    @user = User.new(user_params) #まだ実装は終わってないぜ
    if @user.save
      log_in @user
      flash[:success] = "ようこそtwitterへ"
      #ユーザーのページへ返す（ユーザー＝@user）
      redirect_to @user
      #redirect_to はuser_url(@user)と一緒
    else
      #routesの設定と同じでnewアクションが実行される
      render 'new'
    end
  end

  private

  def user_params
    #name, emailなどってくる情報をここで指定することでセキュリティを高める
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
