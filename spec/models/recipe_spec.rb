require 'rails_helper'

RSpec.describe Recipe, type: :model do

  it { should belong_to(:user) }
  it { should have_many(:recipe_foods).dependent(:destroy) }
  it { should have_many(:foods).through(:recipe_foods) }

  describe 'Factory' do
    it 'is valid with valid attributes' do
      expect(build(:recipe)).to be_valid
    end
  end
end
