class CreateWallets < ActiveRecord::Migration[8.0]
  def change
    create_table :wallets do |t|
      t.references :owner, polymorphic: true, null: false
      t.decimal :balance, default: 0, null: false

      t.timestamps
    end
  end
end
