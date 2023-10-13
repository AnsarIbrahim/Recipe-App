require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it 'has a valid factory' do
    inventory = FactoryBot.build(:inventory)
    expect(inventory).to be_valid
  end

  it 'is not valid without a name' do
    inventory = FactoryBot.build(:inventory, name: nil)
    expect(inventory).to_not be_valid
  end

  it 'is not valid with a name less than 3 characters' do
    inventory = FactoryBot.build(:inventory, name: 'ab')
    expect(inventory).to_not be_valid
  end

  it 'is not valid with a name longer than 50 characters' do
    inventory = FactoryBot.build(:inventory, name: 'a' * 51)
    expect(inventory).to_not be_valid
  end

  it 'is not valid without a description' do
    inventory = FactoryBot.build(:inventory, description: nil)
    expect(inventory).to_not be_valid
  end

  it 'belongs to a user' do
    user_association = Inventory.reflect_on_association(:user)
    expect(user_association.macro).to eq(:belongs_to)
  end

  it 'has many inventory_foods' do
    inventory = Inventory.reflect_on_association(:inventory_foods)
    expect(inventory.macro).to eq(:has_many)
  end

  it 'has many foods through inventory_foods' do
    inventory = Inventory.reflect_on_association(:foods)
    expect(inventory.macro).to eq(:has_many)
    expect(inventory.options[:through]).to eq(:inventory_foods)
  end
end
