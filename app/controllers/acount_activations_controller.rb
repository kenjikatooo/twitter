class AcountActivationsController < ApplicationController

    #アカウントを有効化するeditアクションを定義する
    def edit
        #アドレスを引っ張ってきてユーザーを定義する
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            #activatedキーとactivated_atキーを更新する
            user.update_attirbute(:activated, true)
            user.update_attirbute(:activated_at, Time.zone.now)
            #ログインしてユーザーページへリダイレクト
            log_in user
            flash[:success] = "アカウントが認証されました！"
            redirect_to user
        else
            flash[:danger] = "無効なリンクです"
            redirect_to root_url
        end
    end
end
