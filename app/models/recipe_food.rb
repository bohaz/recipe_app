class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  after_create :decrease_food_quantity
  before_update :store_previous_quantity
  after_update :update_food_quantity_after_edit
  before_destroy :return_food_quantity

  attr_accessor :previous_quantity

  private

  def decrease_food_quantity
    food.update(quantity: food.quantity - quantity)
  end

  def store_previous_quantity
    self.previous_quantity = quantity_was
  end

  def update_food_quantity_after_edit
    difference = previous_quantity - quantity
    food.update(quantity: food.quantity + difference)
  end

  def return_food_quantity
    food.update(quantity: food.quantity + quantity)
  end
end
