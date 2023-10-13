class RenameUsersToCreateUsers < ActiveRecord::Migration[7.1]
  def up
    # Check if the "create_users" table doesn't exist before renaming.
    unless table_exists?(:create_users)
      rename_table :users, :create_users
    end
  end

  def down
    # Define how to revert the renaming if necessary.
    unless table_exists?(:users)
      rename_table :create_users, :users
    end
  end
end
