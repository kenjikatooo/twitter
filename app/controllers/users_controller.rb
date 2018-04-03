class UsersController < ApplicationController
  def new
  end

  def show
    #@userを定義しshow.htmlに渡す
    @user = User.find(params[:id])
  end
end
