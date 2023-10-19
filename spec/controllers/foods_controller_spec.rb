require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  let(:user) { create(:user) }
  let(:food) { create(:food, user: user) }
  
  before do
    sign_in user  # Asegúrate de tener un helper para simular que un usuario está autenticado.
  end

  describe 'GET #index' do
    it 'assigns the requested user to @user' do
      get :index
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns the foods of user to @foods' do
      get :index
      expect(assigns(:foods)).to match_array([food])
    end
  end

  describe 'GET #new' do
    it 'assigns a new Food to @food' do
      get :new
      expect(assigns(:food)).to be_a_new(Food)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new food' do
        expect {
          post :create, params: { food: attributes_for(:food) }
        }.to change(Food, :count).by(1)
      end

      it 'redirects to the foods index' do
        post :create, params: { food: attributes_for(:food) }
        expect(response).to redirect_to foods_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the food' do
        expect {
          post :create, params: { food: attributes_for(:food, name: nil) }
        }.to_not change(Food, :count)
      end

      it 're-renders the new method' do
        post :create, params: { food: attributes_for(:food, name: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
  it 'deletes the food' do
    food
    expect {
      delete :destroy, params: { id: food.id }
    }.to change(Food, :count).by(-1)
  end

  it 'redirects to the foods index' do
    delete :destroy, params: { id: food.id }
    expect(response).to redirect_to foods_path
  end
end

end


   
