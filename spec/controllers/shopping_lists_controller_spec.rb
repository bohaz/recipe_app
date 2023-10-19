require 'rails_helper'

RSpec.describe ShoppingListsController, type: :controller do
  describe 'GET #index' do
    before do
      @user = FactoryBot.create(:user) 

      sign_in @user 
      get :index
    end

    it 'assigns current user to @user' do
      expect(assigns(:user)).to eq(@user)
    end

    it 'assigns a shopping list to @shopping_list' do
      expect(assigns(:shopping_list)).to be_a(Hash)
      expect(assigns(:shopping_list)).to have_key(:shopping_list)
      expect(assigns(:shopping_list)).to have_key(:total_value)
      expect(assigns(:shopping_list)).to have_key(:total_items)
    end
  end
end
