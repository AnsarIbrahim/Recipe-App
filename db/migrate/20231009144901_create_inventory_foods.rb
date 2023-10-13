class CreateInventoryFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :inventory_foods do |t|
      t.integer :quantity, default: 0
      t.references :food, null: false, foreign_key: true
      t.references :inventory, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end