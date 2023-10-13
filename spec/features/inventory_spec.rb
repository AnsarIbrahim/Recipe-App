require 'rails_helper'

RSpec.describe 'Inventory management', type: :feature do
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

  it 'allows a user to create an inventory' do
    visit new_inventory_path

    fill_in 'name', with: 'Inventory 1'
    fill_in 'description', with: 'Invent 1 desc'

    click_button 'Create Inventory'
    sleep(0.5)
    expect(page).to have_text('Inventory successfully added')
  end

  it 'allows a user to remove an inventory' do
    visit new_inventory_path

    fill_in 'name', with: 'Inventory 1'
    fill_in 'description', with: 'Invent 1 desc'
    click_button 'Create Inventory'

    sleep(0.5)
    visit inventories_path
    within('form') do
      click_button 'Remove'
    end
    sleep(2)
    expect(page).not_to have_text('Inventory 1')
  end

  it 'allows user to add food to Inventory' do
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

    sleep(0.5)
    expect(page).to have_text('Inventory successfully added')

    visit inventories_path

    click_link 'Inventory 1'
    click_link 'Add Inventory Food'
    sleep(2)
    select Food.first.name, from: 'inventory_food[food_id]'

    fill_in 'inventory_food[quantity]', with: 5

    within('form') do
      click_button 'Create Inventory Food'
    end

    sleep(1)
    expect(page).to have_text('Food added to inventory')
  end
end
