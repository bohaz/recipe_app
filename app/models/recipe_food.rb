class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  after_create :update_food_quantity

  private

  def update_food_quantity
    food.update(quantity: food.quantity - quantity)
  end
end
