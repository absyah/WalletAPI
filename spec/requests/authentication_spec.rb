require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let(:user) { User.create!(name: "Test", email: "test@example.com", password: "password") }

  it "authenticates the user and returns a token" do
    post "/auth/login", params: { email: user.email, password: "password" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to have_key("token")
  end
end
