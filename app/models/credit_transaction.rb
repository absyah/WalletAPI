class CreditTransaction < Transaction
  before_create :set_credit

  private

  def set_credit
    self.source_wallet_id = nil
    wallet.update!(balance: wallet.balance + amount)
  end
end
