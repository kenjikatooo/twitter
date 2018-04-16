class User < ApplicationRecord
    attr_accessor :remember_token
    #保存前に強制的にメールアドレスを小文字に変換
    before_save { self.email = email.downcase }
    #validateメソッドを使って情報の有効性を定める
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 240 }, format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false }
    has_secure_password
    #有効なパスワードを定義する
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    #coookiesに保存する用にランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    #永続セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    #渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        #ユーザーのログイン情報を破棄する
        update_attribute(:remember_digest, nil)
    end
end
