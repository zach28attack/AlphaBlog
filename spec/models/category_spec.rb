require 'rails_helper'

RSpec.describe Category, type: :model do
let(:category) {FactoryBot.create(:category)}
  context "with valid name" do
    it "should be valid" do 
      expect(category).to be_valid
    end
  end

  context "with invalid name" do
    it "should be invalid" do 
      category.name = ""
      expect(category).to_not be_valid
    end
  end
end
