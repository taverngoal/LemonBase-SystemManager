class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :crypted_password, :null => false
      t.string :salt, :null => false

      t.string :name, index: true
      t.string :nick
      t.datetime :birth
      t.string :address
      t.string :phone, limit: 20

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end