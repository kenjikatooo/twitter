class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    #usersテーブルの中のemailというカラムにインデックスを追加
    add_index :users, :email, unique: true
  end
end
