require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates a wallet after user creation" do
    user = User.create!(name: "Test User", email: "test@example.com", password: "password")
    expect(user.wallet).not_to be_nil
  end
end
