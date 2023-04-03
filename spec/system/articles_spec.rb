require 'rails_helper'

# DISLAIMER: While testing this application on my laptop I need to slow down 
# the execution of the rspec tests with Capybara or else it evaluates certain
# criteria before the page updates

def sign_in_as(user)
  logged_in ||= false
  if logged_in == false
    visit root_path
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: "123456"
    click_on "✅"
    logged_in = true
  end
end

def logout
logged_in ||= false
 if logged_in == true
  click "Logout"
  logged_in == false
 end
end

RSpec.describe "Articles", type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let(:article) {FactoryBot.create(:article, user: user)}
  let!(:category) {FactoryBot.create(:category)}
  let!(:article_category) {FactoryBot.create(:article_category, article: article, category: category)}
  

  before do
    driven_by :selenium, using: :safari
    logout
  end

  context "GET article index" do
    it "should redirect to article index" do 
      visit root_path
      sleep 0.1
      click_on "Articles"
      expect(page).to have_content(article.title)
    end
  end

  context "GET article show" do
    it "should redirect to article show" do 
      visit root_path
      sleep 0.1
      click_on "Articles"
      article_element = find('.article', text: article.title)
      article_element.hover
      buttons = article_element.find('.article-buttons')
      view_link = buttons.find('a', text: 'View')
      view_link.click
      expect(current_path).to eq(article_path(article))
    end
  end
  
  context "GET article new" do
    it "should redirect to article new" do 
      sign_in_as(user)
      click_on "Create new article"
      expect(page).to have_current_path(new_article_path)
    end
  end

  describe "POST article" do
    context "without selecting category" do
      it "should create new article" do 
        expect{
        sign_in_as(user)
        click_on "Create new article"
        fill_in "Title", with: "testing test"
        fill_in "Body", with: "Testing the Body with an elaborate string of characters"
        click_button "Save article"
        sleep 0.1
        }.to change(Article, :count).by(1)

      end
    end

    context "with valid fields filled" do
      it "should create new article" do 
        expect{
        sign_in_as(user)
        click_on "Create new article"
        fill_in "Title", with: "testing test."
        fill_in "Body", with: "Testing the Body with an elaborate string of characters"
        select "Sports", from: "article_category_ids"
        click_on "Save article"
        sleep 0.1
        }.to change(Article, :count).by(1)
      end
    end

    context "with blank title" do
      it "should redirect back to articles new" do 
        sign_in_as(user)
        click_on "Create new article"
        fill_in "Title", with: "NO BODY"
        click_button "Save article"
        expect(page).to have_content("Body can't be blank")
      end
    end

    context "with blank body" do
      it "should redirect back to articles new" do 
        sign_in_as(user)
        click_on "Create new article"
        fill_in "Body", with: "NO TITLE NO TITLE NO TITLE"
        click_button "Save article"
        expect(page).to have_content("Title can't be blank")
      end
    end
  end
end
