class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, limit: 32
      t.string :access_key, index: true
      t.string :secret_key
      t.integer :permission_level, default: 0, null: false
      t.boolean :enable, default: 1, null: false

      t.timestamps
    end
  end
end
