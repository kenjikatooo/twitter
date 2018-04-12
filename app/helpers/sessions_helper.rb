module SessionsHelper

    #渡されたユーザーでログインする（sessionメソッドでidを取ってきてログインする）
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        @current_user = @current_user || User.find_by(id: session[:user_id])
    end

    def logged_in?
        #current_userがnilじゃない場合がtrueになるようにする
        !current_user.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
