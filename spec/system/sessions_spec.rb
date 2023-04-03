require 'rails_helper'

def sign_in_with(email, password)
  within("#session_form") do
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on "✅"
  end
end

RSpec.describe "Sessions", type: :system do
  before do
    driven_by :selenium, using: :safari
  end

  let(:user) {FactoryBot.create(:user)}

  context "Login with valid credentials" do
    it "should create a new session" do 
      visit root_path
      click_on "Login"
      sign_in_with(user.email, user.password)
      expect(page).to have_current_path(user_path(user))
    end
  end 

  describe "Login with incorrect credentials" do
    context "with incorrect email" do
      it "should reload page" do 
        visit root_path
        click_on "Login"
        sign_in_with( "w@w.com", user.password)
        expect(page).to_not have_content("#session-form")
      end
    end

    context "with incorrect password" do
      it "should reload page" do 
        visit root_path
        click_on "Login"
        sign_in_with( user.email, "111111")
        expect(page).to_not have_content("#session-form")
      end
    end
  end
end
