require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:article) {FactoryBot.create(:article, user: user)}

  context "with valid attributes" do
    it "should create article" do
      expect(article).to be_valid
    end
  end

  context "with nil user" do
    it "should be invalid" do 
      article.user = nil
      expect(article).to_not be_valid
    end
  end

  describe "an invalid body attribute" do
    context "with less than 10 characters" do
      it "should be invalid" do 
        article.body = "invalid"
        expect(article).to_not be_valid
      end
    end

    context "with nil body" do
      it "should be invalid" do 
        article.body = nil
        expect(article).to_not be_valid
      end
    end
  end

  describe "with invalid title attribute" do
    context "title with less than 5 characters" do
      it "should be invalid" do 
        article.title = "1234"
        expect(article).to_not be_valid
      end
    end

    context "with nil title" do
      it "should be invalid" do 
        article.title = nil
        expect(article).to_not be_valid
      end
    end
  end
end