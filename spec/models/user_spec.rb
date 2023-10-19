require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is not valid without a password' do
    user.password = nil
    user.password_confirmation = nil
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("can't be blank")
  end
end
