class TransferTransaction < Transaction
  before_create :set_transfer

  private

  def set_transfer
    raise "Insufficient funds" if source_wallet.balance < amount
    source_wallet.update!(balance: source_wallet.balance - amount)
    target_wallet.update!(balance: target_wallet.balance + amount)
  end
end
