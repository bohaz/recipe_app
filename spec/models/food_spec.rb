require 'rails_helper'

RSpec.describe Food, type: :model do
  # Para crear una instancia válida de Food para las pruebas
  let(:food) { FactoryBot.create(:food) }

  # Pruebas para las validaciones
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(food).to be_valid
    end

    it 'is not valid without a name' do
      food.name = nil
      expect(food).to_not be_valid
    end

    it 'is not valid without a measurement_unit' do
      food.measurement_unit = nil
      expect(food).to_not be_valid
    end

    it 'is not valid without a price' do
      food.price = nil
      expect(food).to_not be_valid
    end

    it 'is not valid without a quantity' do
      food.quantity = nil
      expect(food).to_not be_valid
    end
  end

  # Pruebas para las relaciones
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods).dependent(:destroy) }
    it { should have_many(:recipes).through(:recipe_foods) }
  end
end
