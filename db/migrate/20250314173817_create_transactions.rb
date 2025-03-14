class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.decimal :amount
      t.string :transaction_type
      t.integer :source_wallet_id
      t.integer :target_wallet_id

      t.timestamps
    end
  end
end
