module SessionsHelper

    #渡されたユーザーでログインする（sessionメソッドでidを取ってきてログインする）
    def log_in(user)
        session[:user_id] = user.id
    end

    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def current_user?(user)
        #引数userはcurrent_userかどうかを確認するメソッド
        user == current_user
    end

    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    def logged_in?
        #current_userがnilじゃない場合がtrueになるようにする
        !current_user.nil?
    end

    def forget(user)
        user.forget
        #user_idを引っ張ってきて該当ユーザーのクッキーを削除
        cookies.delete(:user_id)
        #同じようにしてremember_tokenを削除
        cookies.delete(:remember_token)
    end

    def log_out
        #上のforget(user)メソッドを使ってクッキー等を削除
        forget(current_user)
        #セッションを破棄
        session.delete(:user_id)
        @current_user = nil
    end

    #記憶したURLにリダイレクトする
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
    
end
