require 'rails_helper'

RSpec.describe ArticleCategory, type: :model do
  let!(:user) {FactoryBot.create(:user)}
  let!(:article) {FactoryBot.create(:article, user: user)}
  let!(:category) {FactoryBot.create(:category)}
  let!(:article_category) {FactoryBot.create(:article_category, article: article, category: category)}

  context "with valid attributes" do
    it "should create article_category" do
      expect(article_category).to be_valid
    end
  end

  context "with nil article" do
    it "should be invalid" do 
      article_category.article = nil
      expect(article_category).to_not be_valid
    end
  end

  context "with nil category" do
    it "should be invalid" do 
      article_category.category = nil
      expect(article_category).to_not be_valid
    end
  end
  
end
