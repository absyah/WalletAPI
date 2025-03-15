require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) { User.create!(name: "Test", email: "test@example.com", password: "password") }
  let(:recipient) { User.create!(name: "Recipient", email: "recipient@example.com", password: "password") }

  it "creates a credit transaction" do
    transaction = CreditTransaction.create!(wallet: user.wallet, amount: 100.0)
    expect(transaction).to be_valid
    expect(user.wallet.balance).to eq(100.0)
  end

  it "creates a debit transaction" do
    user.wallet.update(balance: 100.0)
    transaction = DebitTransaction.create!(wallet: user.wallet, amount: 50.0)
    expect(transaction).to be_valid
    expect(user.wallet.balance).to eq(50.0)
  end

  it "creates a transfer transaction with related credit and debit" do
    user.wallet.update(balance: 100.0)
    transfer = TransferTransaction.create!(wallet: user.wallet, amount: 30.0, source_wallet: user.wallet, target_wallet: recipient.wallet)
    expect(transfer).to be_valid
    expect(user.wallet.balance).to eq(70.0)
    expect(recipient.wallet.balance).to eq(30.0)
  end
end
