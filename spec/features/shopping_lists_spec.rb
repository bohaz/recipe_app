# spec/features/shopping_list_spec.rb

require 'rails_helper'

RSpec.feature 'Shopping List', type: :feature do
  let(:user) { create(:user) }
  let!(:food1) { create(:food, user:, name: 'Apple', quantity: -5, measurement_unit: 'kg', price: 15) }
  let!(:food2) { create(:food, user:, name: 'Banana', quantity: -3, measurement_unit: 'pcs', price: 5) }

  before do
    sign_in user
    visit shopping_list_path
  end

  scenario 'User views the shopping list' do
    expect(page).to have_content('Shopping List')
  end

  scenario 'User sees the total items and total value' do
    expect(page).to have_content('Amount of items to buy: 2') # Adjust this based on your test data
    expect(page).to have_content('Total Value of food needed: $ 90') # Adjust this based on your test data
  end

  scenario 'User sees the shopping list items' do
    expect(page).to have_content('Shopping List')
    expect(page).to have_content('Amount of items to buy: 2')
    expect(page).to have_content('Total Value of food needed: $ 90')

    expect(page).to have_content(food1.name)
    expect(page).to have_content('$5')
    expect(page).to have_content('$15')

    expect(page).to have_content(food2.name)
    expect(page).to have_content('3')
    expect(page).to have_content('$5')
  end

  scenario 'User sees a message if there are no items in the shopping list' do
    # Remove all foods from the shopping list
    Food.all.update(quantity: 0)
    visit shopping_list_path
    expect(page).to have_content('0')
  end
end
