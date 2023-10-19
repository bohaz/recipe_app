require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user  
  end

  describe 'GET #index' do
    it 'assigns all users to @users' do
      another_user = create(:user)
      get :index
      expect(assigns(:users)).to match_array([user, another_user])
    end

    it 'assigns the current user to @user' do
      get :index
      expect(assigns(:user)).to eq(user)
    end
  end
end
