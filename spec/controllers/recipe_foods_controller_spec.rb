require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }
  let(:food) { create(:food, user: user) }
  let(:recipe_food) { create(:recipe_food, recipe: recipe, food: food) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new RecipeFood to @recipe_food' do
      get :new, params: { recipe_id: recipe.id }
      expect(assigns(:recipe_food)).to be_a_new(RecipeFood)
    end

    it 'assigns the available foods to @available_foods' do
      get :new, params: { recipe_id: recipe.id }
      expect(assigns(:available_foods)).to eq([food])
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new RecipeFood' do
        expect {
          post :create, params: { recipe_food: { recipe_id: recipe.id, food_id: food.id, quantity: 2 } }
        }.to change(RecipeFood, :count).by(1)
      end

      it 'redirects to the associated recipe' do
        post :create, params: { recipe_food: { recipe_id: recipe.id, food_id: food.id, quantity: 2 } }
        expect(response).to redirect_to recipe_path(recipe)
      end
    end

    context 'with invalid attributes' do
      # Add tests for scenarios with invalid attributes
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested RecipeFood' do
      recipe_food  # Create the RecipeFood before the test
      expect {
        delete :destroy, params: { id: recipe_food.id }
      }.to change(RecipeFood, :count).by(-1)
    end

    it 'redirects to the associated recipe' do
      delete :destroy, params: { id: recipe_food.id }
      expect(response).to redirect_to recipe_path(recipe)
    end
  end

  describe 'GET #edit' do
  it 'assigns the requested RecipeFood to @recipe_food' do
    get :edit, params: { id: recipe_food.id }
    expect(assigns(:recipe_food)).to eq(recipe_food)
  end

  it 'assigns the available foods to @available_foods' do
    get :edit, params: { id: recipe_food.id }
    expect(assigns(:available_foods)).to eq([food])
  end
end

describe 'PUT #update' do
  context 'with valid attributes' do
    it 'updates the requested RecipeFood' do
      put :update, params: { id: recipe_food.id, recipe_food: { quantity: 3 } }
      recipe_food.reload
      expect(recipe_food.quantity).to eq(3)
    end

    it 'redirects to the associated recipe' do
      put :update, params: { id: recipe_food.id, recipe_food: { quantity: 3 } }
      expect(response).to redirect_to recipe_path(recipe)
    end
  end

  context 'with invalid attributes' do
    # Por ejemplo, podrías intentar actualizar con una cantidad no válida (ej. un número negativo o nulo).
    it 'does not update the RecipeFood' do
      initial_quantity = recipe_food.quantity
      put :update, params: { id: recipe_food.id, recipe_food: { quantity: nil } }
      recipe_food.reload
      expect(recipe_food.quantity).to eq(initial_quantity)
    end

    it 're-renders the edit view' do
      put :update, params: { id: recipe_food.id, recipe_food: { quantity: nil } }
      expect(response).to render_template(:edit)
    end
  end
end
end

