class DebitTransaction < Transaction
  before_create :set_debit

  private

  def set_debit
    raise "Insufficient funds" if wallet.balance < amount
    self.target_wallet_id = nil
    wallet.update!(balance: wallet.balance - amount)
  end
end
