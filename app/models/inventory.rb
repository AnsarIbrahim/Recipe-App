class Inventory < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true

  belongs_to :user, foreign_key: 'user_id'
  has_many :inventory_foods
  has_many :foods, through: :inventory_foods
end
