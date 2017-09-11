require 'rails_helper'

RSpec.describe Wish, type: :model do
  context "validations" do
    it "should have description" do
      should have_db_column(:description).of_type(:text)
    end

    describe "does not validates presence of attributes" do
      it { should_not validate_presence_of(:description)}
    end
  end

  context "associations" do
    it {is_expected.to belong_to(:user)}
  end
end
