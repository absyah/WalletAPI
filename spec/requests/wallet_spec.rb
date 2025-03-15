require 'rails_helper'

RSpec.describe "Wallets", type: :request do
  let(:user) { User.create!(name: "Test", email: "test@example.com", password: "password") }
  let(:token) { JWT.encode({ user_id: user.id }, Rails.application.credentials.secrets.secret_key_base) }

  it "allows a user to check their wallet balance" do
    get "/wallets/#{user.wallet.id}/balance", headers: { "Authorization" => "Bearer #{token}" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to have_key("balance")
  end

  it "allows a user to deposit money" do
    post "/wallets/#{user.wallet.id}/deposit", headers: { "Authorization" => "Bearer #{token}" }, params: { amount: 100.0 }
    expect(response).to have_http_status(:created)
    expect(JSON.parse(response.body)["amount"]).to eq("100.0")
  end

  it "allows a user to withdraw money" do
    user.wallet.update(balance: 100.0)
    post "/wallets/#{user.wallet.id}/withdraw", headers: { "Authorization" => "Bearer #{token}" }, params: { amount: 50.0 }
    expect(response).to have_http_status(:created)
    expect(JSON.parse(response.body)["amount"]).to eq("50.0")
  end

  it "allows a user to transfer money between wallets" do
    recipient = User.create!(name: "Recipient", email: "recipient@example.com", password: "password")
    user.wallet.update(balance: 100.0)
    post "/wallets/transfer", headers: { "Authorization" => "Bearer #{token}" }, params: { source_wallet_id: user.wallet.id, target_wallet_id: recipient.wallet.id, amount: 30.0 }
    expect(response).to have_http_status(:created)
    expect(JSON.parse(response.body)["amount"]).to eq("30.0")
  end
end
