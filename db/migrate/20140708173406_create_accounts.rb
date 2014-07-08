class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :title, null: false
      t.decimal :amount, default: 0, null: false
      t.integer :creator, null: false
      t.integer :officer, null: false
      t.boolean :is_public, null: false, default: false

      t.timestamps
    end
  end
end
