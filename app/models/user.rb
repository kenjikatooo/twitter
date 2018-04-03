class User < ApplicationRecord
    #保存前に強制的にメールアドレスを小文字に変換
    before_save { self.email = email.downcase }
    #validateメソッドを使って情報の有効性を定める
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 240 }, format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false }
    has_secure_password
    #有効なパスワードを定義する
    validates :password, presence: true, length: { minimum: 6 }
end
