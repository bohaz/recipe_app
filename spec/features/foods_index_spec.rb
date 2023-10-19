require 'rails_helper'

RSpec.feature 'Foods', type: :feature do
  let(:user) { create(:user) }
  let!(:food1) { create(:food, user:, name: 'Apple', quantity: 5, measurement_unit: 'kg', price: 1.5) }
  let!(:food2) { create(:food, user:, name: 'Banana', quantity: 3, measurement_unit: 'pcs', price: 0.5) }

  before do
    sign_in user
    visit foods_path
  end

  scenario 'User sees the list of their foods' do
    expect(page).to have_content(food1.name)
    expect(page).to have_content(food1.measurement_unit)
    expect(page).to have_content("$ #{food1.price}")

    expect(page).to have_content(food2.name)
    expect(page).to have_content(food2.measurement_unit)
    expect(page).to have_content("$ #{food2.price}")
  end

  scenario 'User sees a message if there are no foods' do
    Food.destroy_all
    visit foods_path

    expect(page).to have_content('There are no foods')
  end
end
