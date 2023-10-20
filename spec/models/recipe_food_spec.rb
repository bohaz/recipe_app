# spec/models/recipe_food_spec.rb

require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:food) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe 'callbacks' do
    let(:food) { create(:food, quantity: 10) }
    let(:recipe_food) { create(:recipe_food, food:, quantity: 5) }

    context 'after_create :decrease_food_quantity' do
      it 'decreases the food quantity by the recipe food quantity' do
        expect(food.reload.quantity).to eq(10)
      end
    end

    context 'after_update :update_food_quantity_after_edit' do
      before do
        recipe_food.update(quantity: 3)
      end

      it 'updates the food quantity based on the difference in recipe food quantity' do
        expect(food.reload.quantity).to eq(7)
      end
    end

    context 'before_destroy :return_food_quantity' do
      before do
        recipe_food.destroy
      end

      it 'returns the food quantity back when the recipe food is destroyed' do
        expect(food.reload.quantity).to eq(10)
      end
    end
  end
end
