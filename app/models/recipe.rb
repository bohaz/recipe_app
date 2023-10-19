class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods
  validates :name, presence: true
  def total_price
    recipe_foods.sum { |rf| rf.quantity * rf.food.price }
  end
end
