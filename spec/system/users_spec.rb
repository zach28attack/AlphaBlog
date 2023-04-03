require 'rails_helper'

def sign_up(username, email, password)
  visit root_path
  click_on "Signup"
  expect(page).to have_selector("form#user-form")
  fill_in "Username", with: username
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_on "✅"
end

def sign_in(username, email, password)
  visit root_path
  click_on "Login"
  # expect(page).to have_selector("form#session-form")
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_on "✅"
end

def show_user_form
  visit user_path(user)
  button = find("#settings-dropdown-toggle")
  button.click
  user_form_toggle = find("#user-form-toggle")
  user_form_toggle.click
end

RSpec.describe "Users", type: :system do
  let!(:user) {FactoryBot.create(:user)}
  
  before do
    driven_by :selenium, using: :safari
  end

  

  describe "Signing up" do
    context "with valid attributes" do
      it "should create new user" do 
        expect{
        
        sign_up("Zachary", "email@test.com", "Password")
        sleep 0.1
        }.to change(User, :count).by(1)
      end
    end

    context "with invalid username" do
      it "shouldn't create new user" do 
        expect{
        sign_up("B", "email@testing.com", "12121212")
        sleep 0.1
        }.to change(User, :count).by(0)
      end

      it "should display errormessage" do 
        sign_up("B", "email@testing.com", "12121212")
        sleep 0.1
        expect(page).to have_selector("#username-error")
      end
    end

    context "with invalid email" do
      it "shouldn't create user" do 
        expect{
          sign_up("Testing", "email.com", "Password")
          sleep 0.1
        }.to change(User, :count).by(0)
      end
    end

    context "With invalid password" do
      it "shouldn't create user" do 
        expect{
          sign_up("Username", "Email.test.com", "12")
          sleep 0.1
        }.to change(User, :count).by(0)
      end

      it "should display error message" do
        sign_up("Username", "Email.test.com", "12")
        sleep 0.1
        expect(page).to have_selector("#password-error")
      end
    end
  end
  
  describe "GET User show" do
    context "with existing user's articles" do
    let!(:article) {FactoryBot.create(:article, user: user)}
    let!(:article_2) {FactoryBot.create(:article_2, user: user)}
      it "should display the user's articles on page" do 
        sign_in(user.username, user.email, user.password)
        sleep 0.1
        expect(page).to have_content(article.title)
        expect(page).to have_content(article_2.title)
      end
    end

    context "navigating to user edit button" do
      it "should render user edit form" do
        sign_in(user.username, user.email, user.password) 
        show_user_form
        expect(page).to have_selector("#user-form-toggle")
        expect(page).to have_selector("#user-form")
      end
    end
  end
########################################################################################
  describe "UPDATE User" do
    context "with valid attributes" do
      it "should update user" do 
        
        expect{
          sign_in(user.username, user.email, user.password)
          sleep 0.1
          show_user_form
          sleep 0.01
          fill_in "Username", with: "WWE KING"
          fill_in "Email", with: "test@case.com"
          fill_in "Password", with: user.password
          user_form = find("#user-form")
          button = user_form.find("input[type=submit]")
          button.click
          sleep 0.1
          user.reload
          sleep 0.1
        }.to change(user, :updated_at).from(user.created_at)
      end
    end

    # context "with invalid email" do
    #   it "shouldn't update" do 
    #     show_user_form
    #     sleep 0.1
    #     expect{
    #       fill_in "Username", with: "WWE KING"
    #       fill_in "Email", with: ""
    #       fill_in "Password", with: "Password"
    #     }.to_not change(user, :attributes).from(user.attributes)
    #   end
    # end
  end
end
