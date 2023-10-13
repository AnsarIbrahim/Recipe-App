class InventoryFood < ApplicationRecord
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :inventory, foreign_key: :inventory_id
  belongs_to :food, foreign_key: :food_id
end
