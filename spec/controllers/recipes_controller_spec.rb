require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  before do
    sign_in user  
  end

  describe 'GET #index' do
    it 'assigns current user recipes to @recipes' do
      another_recipe = create(:recipe, user: user)
      get :index
      expect(assigns(:recipes)).to match_array([recipe, another_recipe])
    end

    it 'assigns the current user to @user' do
      get :index
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested recipe to @recipe' do
      get :show, params: { id: recipe.id }
      expect(assigns(:recipe)).to eq(recipe)
    end

    it 'assigns the current user to @user' do
      get :show, params: { id: recipe.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new recipe' do
        expect {
          post :create, params: { recipe: attributes_for(:recipe) }
        }.to change(Recipe, :count).by(1)
      end

      it 'redirects to recipes path' do
        post :create, params: { recipe: attributes_for(:recipe) }
        expect(response).to redirect_to recipes_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the recipe' do
        expect {
          post :create, params: { recipe: attributes_for(:recipe, name: nil) }
        }.to_not change(Recipe, :count)
      end

      it 're-renders the new view' do
        post :create, params: { recipe: attributes_for(:recipe, name: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
  context 'when the user owns the recipe' do
    it 'deletes the recipe' do
      recipe
      expect {
        delete :destroy, params: { id: recipe.id }
      }.to change(Recipe, :count).by(-1)
    end

    it 'redirects to recipes path with a success message' do
      delete :destroy, params: { id: recipe.id }
      expect(response).to redirect_to recipes_path
      expect(flash[:notice]).to eq 'Recipe was successfully deleted.'
    end
  end

  context 'when the user does not own the recipe' do
    let(:other_user) { create(:user) }
    let(:other_recipe) { create(:recipe, user: other_user) }

    it 'does not delete the recipe' do
      other_recipe
      expect {
        delete :destroy, params: { id: other_recipe.id }
      }.to_not change(Recipe, :count)
    end

    it 'redirects to recipes path with an alert message' do
      delete :destroy, params: { id: other_recipe.id }
      expect(response).to redirect_to recipes_path
      expect(flash[:alert]).to eq 'You are not authorized to delete this recipe.'
    end
  end
end

describe 'POST #toggle_public' do
  it 'toggles the public status of the recipe' do
    original_status = recipe.public
    post :toggle_public, params: { id: recipe.id }
    expect(recipe.reload.public).to eq(!original_status)
  end

  it 'redirects to the recipe' do
    post :toggle_public, params: { id: recipe.id }
    expect(response).to redirect_to recipe
  end
end
end

