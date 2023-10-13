class RenameUsersToCreateUsers < ActiveRecord::Migration[7.1]
  def change
    rename_table :users, :create_users
  end
end
