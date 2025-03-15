class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true
  belongs_to :transfer_transaction, class_name: 'TransferTransaction', optional: true
  validates :amount, numericality: { greater_than: 0 }
end
