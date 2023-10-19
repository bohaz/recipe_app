require 'rails_helper'

RSpec.feature "PublicRecipes", type: :feature do
  let(:user) { create(:user) }
  let!(:public_recipe) { create(:recipe, user: user, name: "Public Recipe", public: true) }
  
  let!(:recipe_food) { create(:recipe_food, recipe: public_recipe) } 

  before do
    visit public_recipes_path
  end

  scenario "User sees the title 'List of all public recipes:'" do
    expect(page).to have_content("List of all public recipes:")
  end

  scenario "User sees the public recipes" do
    expect(page).to have_link(public_recipe.name, href: recipe_path(public_recipe))
    expect(page).to have_content(public_recipe.user.name)
    expect(page).to have_content("Total food items: #{public_recipe.recipe_foods.count}")
    expect(page).to have_content("Total price: $ ... #{public_recipe.total_price}")
  end
end
