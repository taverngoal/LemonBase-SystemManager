class CreateAccountDetails < ActiveRecord::Migration
  def change
    create_table :account_details do |t|
      t.string :title, null: false
      t.decimal :sum, null: false, default: 0
      t.references :user, index: true
      t.string :memo
      t.string :purpose
      t.references :account, index: true
      t.decimal :amount, null: false, default: 0

      t.timestamps
    end
  end
end
