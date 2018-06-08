class AddIsLoggedInToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_logged_in, :boolean
  end
end
