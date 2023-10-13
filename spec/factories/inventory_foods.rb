FactoryBot.define do
  factory :inventory_food do
    quantity { 1 }
    association :inventory, factory: :inventory
    association :food, factory: :food
  end
end
