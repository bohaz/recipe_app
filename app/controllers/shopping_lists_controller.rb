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

    @user.foods.each do |food|
      next unless food.quantity.negative?

      quantity_needed = -food.quantity
      total_value += quantity_needed * food.price
      total_items += 1
      shopping_list[food.name] = { quantity: quantity_needed, price: food.price }
    end

    {
      shopping_list:,
      total_value:,
      total_items:
    }
  end
end
