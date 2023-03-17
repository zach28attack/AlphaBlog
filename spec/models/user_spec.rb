require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {FactoryBot.create(:user)}

  describe "with invalid username" do
    context "with nil username" do
      it "should be invalid" do 
        user.username = nil
        expect(user).to_not be_valid
      end
    end

    context "with a username shorter than 3 characters" do
      it "should be invalid" do 
        user.username = "Fe"
        expect(user).to_not be_valid
      end
    end

    context "when creating another user with a taken username" do
      it "should be invalid" do 
        user2 = user.dup 
        user2.email = "new@email.com"
        expect(user2).to_not be_valid
      end
    end
  end

  describe "with invalid email" do
    context "with nil email" do
      it "should be invalid" do 
        user.email = nil
        expect(user).to_not be_valid
      end
    end

    context "with an email without @ or .com" do
      it "should be invalid" do 
        user.email = "email"
        expect(user).to_not be_valid
      end
    end

    context "when creating another user with a taken email" do
      it "should be invalid" do 
        user2 = user.dup 
        user2.username = "@USERNAME"
        expect(user2).to_not be_valid
      end
    end
  end
end
