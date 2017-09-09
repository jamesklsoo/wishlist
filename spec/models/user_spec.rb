require 'rspec'
require 'rspec/given'
require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "should have all specific attributes" do
      should have_db_column(:fullname).of_type(:string)
      should have_db_column(:email).of_type(:string)
      should have_db_column(:password_digest).of_type(:string)
    end

    describe "validates presence of attributes" do
      it { is_expected.to validate_presence_of(:fullname)}
      it { is_expected.to validate_presence_of(:email)}
      it { is_expected.to validate_presence_of(:password)}
    end

    describe "validates valid password" do
      it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(20)}
    end

    # happy_path
    describe "can be created when all attributes are present" do
      When(:user) {User.create (
                     fullname: "Abcde",
                     email: "abcde@gmail.com",
                     password: "123456",
      )}
      Then {user.valid? == true}
    end

    # edgy_path
    describe "cannot be created without fullname" do
      When(:user) {User.create(email: "abcde@gmail.com", password: "123456")}
      Then { user.valid? == false}
    end

    describe "cannot be created without email" do
      When(:user) {User.create(fullname: "Abcde", password: "123456")}
      Then {user.valid? == false}
    end

    describe "cannot be created without password" do
      When(:user) {User.create(fullname: "Abcde", email: "abcde@gmail.com")}
      Then {user.valid? == false}
    end

    describe "should permit valid email only" do
      let(:user1) {User.create(fullname: "Abcde", email: "abcde@gmail.com", password: "123456")}
      let(:user2) {User.create(fullname: "Harry", email: "hk.com", password: "123456")}

      # happy_path
      it "sign up with valid email" do
        expect(user1).to be_valid
      end

      # edgy_path
      it "sign up with invalid email" do
        expect(user2).to be_invalid
      end
    end
  end

  context "associations with dependency" do
    it { is_expected.to have_many(:authentications).dependent(:destroy)}
    it { is_expected.to have_many(:wishes)}
  end
end
