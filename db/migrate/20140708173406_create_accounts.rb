class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :title
      t.decimal :amount, default: 0
      t.integer :creator
      t.integer :officer
      t.boolean :is_public

      t.timestamps
    end
  end
end
