require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  it 'has a valid factory' do
    inventory_food = FactoryBot.build(:inventory_food)
    expect(inventory_food).to be_valid
  end

  it 'requires quantity to be a non-negative integer' do
    inventory_food = FactoryBot.build(:inventory_food, quantity: -1)
    expect(inventory_food).to_not be_valid

    inventory_food = FactoryBot.build(:inventory_food, quantity: 5) # Adjust the value as needed
    expect(inventory_food).to be_valid
  end

  it 'requires quantity to be a non-negative integer' do
    inventory_food = FactoryBot.build(:inventory_food, quantity: -1)
    expect(inventory_food).to_not be_valid

    inventory_food = FactoryBot.build(:inventory_food, quantity: 5) # Adjust the value as needed
    expect(inventory_food).to be_valid
  end

  it 'belongs to an inventory' do
    inventory_association = InventoryFood.reflect_on_association(:inventory)
    expect(inventory_association.macro).to eq(:belongs_to)
  end

  it 'belongs to a food' do
    food_association = InventoryFood.reflect_on_association(:food)
    expect(food_association.macro).to eq(:belongs_to)
  end
end
