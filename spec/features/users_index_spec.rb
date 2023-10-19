require 'rails_helper'

RSpec.feature "UsersIndex", type: :feature do
  before do
    @user1 = create(:user, name: "User One")
    @user2 = create(:user, name: "User Two")
    sign_in @user1  
  end

  scenario "visitor views the list of all users" do
    visit root_path

    expect(page).to have_content("List of all users:")
    expect(page).to have_selector("ul")

    within(".users-index-ul") do
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
    end
  end
end
