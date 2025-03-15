class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :transactions
end
