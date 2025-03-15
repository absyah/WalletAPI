class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.decimal :amount
      t.string :type
      t.integer :source_wallet_id
      t.integer :target_wallet_id
      t.integer :transfer_transaction_id

      t.timestamps
    end
  end
end
