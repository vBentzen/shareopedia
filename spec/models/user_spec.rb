require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "what@what.com", password: "funkytown", password_confirmation: "funkytown") }
  describe "attributes" do

    it "should respond to role" do
      expect(user).to respond_to(:role)
    end

    # #2
    it "should respond to admin?" do
      expect(user).to respond_to(:admin?)
    end

    # #3
    it "should respond to member?" do
      expect(user).to respond_to(:member?)
    end
  end

  describe "roles" do
    # #4
    it "should be member by default" do
      expect(user.role).to eql("member")
    end

    # #5
    context "member user" do
      it "should return true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "should return false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    # #6
    context "admin user" do
      before do
        user.admin!
      end

      it "should return false for #member?" do
        expect(user.member?).to be_falsey
      end

      it "should return true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end
end
