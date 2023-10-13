class AddDescToInventories < ActiveRecord::Migration[7.1]
  def change
    add_column :inventories, :description, :text, null: false
  end
end
