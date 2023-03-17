require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:article) {FactoryBot.create(:article, user: user)}
  context "with valid attributes" do
    it "should create article" do
      expect(article).to be_valid
    end
  end
end
