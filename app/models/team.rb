class Team < ApplicationRecord
  has_one :wallet, as: :owner, dependent: :destroy
  after_create :create_wallet

  private
  def create_wallet
    Wallet.create!(owner: self, balance: 0.0)
  end
end
