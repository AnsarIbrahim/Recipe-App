require 'rails_helper'

RSpec.describe 'Shopping list generator ', type: :feature do
  before(:each) do
    user = FactoryBot.create(:user)
    user.confirm

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password123'
    click_button 'Log in'
    sleep(1)
    expect(page).to have_content('Signed in successfully.')
  end

  it 'appropriately generates a shopping list' do
    visit new_food_path
    fill_in 'name', with: 'Apple'
    fill_in 'measurement_unit', with: 'Grams'
    fill_in 'price', with: 10
    click_button 'Add Food'

    sleep(1)
    expect(page).to have_text('Food successfully added')

    visit new_inventory_path

    fill_in 'name', with: 'Inventory 1'
    fill_in 'description', with: 'Invent 1 desc'
    click_button 'Create Inventory'

    visit new_recipe_path
    fill_in 'recipe[name]', with: 'Apple Pie'
    fill_in 'recipe[preparation_time]', with: 2
    fill_in 'recipe[cooking_time]', with: 2
    fill_in 'recipe[description]', with: 'Pie with apples'

    within('form') do
      click_button 'Add Recipe'
    end
    sleep(0.5)
    expect(page).to have_text('Recipe was successfully created.')

    click_link 'Apple Pie'
    click_button 'Generate Shopping List'

    select(Inventory.first.name, from: 'Inventory')
    within('form#shopping-list-form') do
      click_button 'Generate'
    end
    sleep(3)
    expect(page).to have_text('Shopping List')
  end
end
