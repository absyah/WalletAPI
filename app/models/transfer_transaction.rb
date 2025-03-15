class TransferTransaction < Transaction
  after_create :set_transfer

  private

  def set_transfer
    raise "Insufficient funds" if source_wallet.balance < amount

    ActiveRecord::Base.transaction do
      DebitTransaction.create!(wallet: source_wallet, amount: amount, target_wallet: target_wallet, transfer_transaction: self)
      CreditTransaction.create!(wallet: target_wallet, amount: amount, source_wallet: source_wallet, transfer_transaction: self)
    end
  end
end
