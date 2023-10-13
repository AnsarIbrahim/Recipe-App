FactoryBot.define do
  factory :inventory do
    name { 'Sample Inventory' }
    description { 'Sample description' }
    association :user, factory: :user
  end
end
