class CreateAccountDetails < ActiveRecord::Migration
  def change
    create_table :account_details do |t|
      t.string :title
      t.decimal :sum
      t.integer :type
      t.references :user, index: true
      t.string :memo
      t.string :purpose
      t.references :account, index: true

      t.timestamps
    end
  end
end
