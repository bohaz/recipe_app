require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  let(:user) { create(:user) }
  let!(:my_recipe) { create(:recipe, user:, name: 'Chicken Recipe', description: 'Delicious roasted chicken') }
  let!(:other_recipe) { create(:recipe, user: create(:user), name: 'Fish Recipe', description: 'Tasty fried fish') }

  before do
    sign_in user
    visit recipes_path
  end

  scenario "User sees the title 'My recipies'" do
    expect(page).to have_content('My recipies')
  end

  scenario 'User sees their recipes and not those of other users' do
    expect(page).to have_link(my_recipe.name, href: recipe_path(my_recipe))
    expect(page).to have_content(my_recipe.description)

    expect(page).not_to have_content(other_recipe.name)
    expect(page).not_to have_content(other_recipe.description)
  end

  scenario 'User can delete their recipe' do
    within('.recipes-index-li', text: my_recipe.name) do
      click_button 'Remove'
    end

    expect(page).not_to have_content(my_recipe.name)
    expect(page).to have_content('Recipe was successfully deleted.')
  end

  scenario "User sees the 'Add New Recipe' button" do
    expect(page).to have_link('Add New Recipe', href: new_recipe_path)
  end
end
