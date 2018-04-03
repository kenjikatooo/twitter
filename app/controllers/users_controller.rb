class UsersController < ApplicationController
  def new
    #@userをこれから使っていくので変数として定義しておく
    @user = User.new
  end

  def show
    #@userを定義しshow.htmlに渡す
    @user = User.find(params[:id])
  end
end
