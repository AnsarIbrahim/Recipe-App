require 'rails_helper'

RSpec.describe 'Food management', type: :feature do
  before(:each) do
    DatabaseCleaner.clean
  end

  before(:each) do
    user = FactoryBot.create(:user)
    user.confirm

    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password123'
    click_button 'Log in'
    sleep(1)
  end

  it 'allows a user to create a food' do
    visit new_food_path

    fill_in 'name', with: 'Apple'
    fill_in 'measurement_unit', with: 'Grams'
    fill_in 'price', with: 10
    click_button 'Add Food'

    expect(page).to have_text('Food successfully added')
  end
end
