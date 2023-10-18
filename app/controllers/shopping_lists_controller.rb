class ShoppingListsController < ApplicationController
  def index
    @user = current_user
    @shopping_list = calculate_shopping_list
  end

  private

  def calculate_shopping_list
    shopping_list = {}
    total_value = 0
    total_items = 0
  
    @user.recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        food = recipe_food.food
        quantity_needed = recipe_food.quantity
        quantity_owned = @user.foods.find_by(id: food.id)&.quantity.to_i
        difference = quantity_needed - quantity_owned
        if difference > 0
          shopping_list[food.name] = { quantity: difference, price: food.price }
          total_value += difference * food.price
          total_items += 1
        end
      end
    end
  
    { shopping_list: shopping_list, total_value: total_value, total_items: total_items }
  end
end
