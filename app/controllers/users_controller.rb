class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only:[:edit, :update]

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
    @user = User.new(user_params)
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

  def edit
    #下のコードはcorrect_usreで@userを定義してるから不要。DRYの原則や
    #@user = User.find(params[:id])
  end

  def update
    #保存するユーザーの情報を取ってくる
    #以下の@userもcorrect_userで定義してるからいらない
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to user_path(@user)
    else
      #編集ページに戻る
      #ここでredirect_to user_edit_pathってしたらエラーメッセが出ない
      #理由はedit.html.erbにもともとエラーメッセが表示されるようパーシャルを設定してあるから
      render 'edit'
    end
  end

  private

  def user_params
    #name, emailなどってくる情報をここで指定することでセキュリティを高める
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

  def correct_user
    #適当なユーザーのidを取ってくる
    @user = User.find(params[:id])
    #現在のユーザーではなかったらホームへ戻す
    redirect_to(root_url) unless current_user?(@user)
  end
end
