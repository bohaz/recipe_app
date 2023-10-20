require 'rails_helper'
RSpec.describe PublicRecipesController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let!(:public_recipe1) { create(:recipe, public: true) }
    let!(:public_recipe2) { create(:recipe, public: true) }
    let!(:private_recipe) { create(:recipe, public: false) }
    before do
      sign_in user
      get :index
    end
    it 'assigns current_user to @user' do
      expect(assigns(:user)).to eq(user)
    end
    it 'fetches all public recipes' do
      expect(assigns(:public_recipes)).to match_array([public_recipe1, public_recipe2])
    end
    it 'does not fetch private recipes' do
      expect(assigns(:public_recipes)).not_to include(private_recipe)
    end
    it 'renders the index view' do
      expect(response).to render_template(:index)
    end
  end
end
