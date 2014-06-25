class AddConfigs < ActiveRecord::Migration
  def change
    create_table :configs do |t|
      t.string :key, null: false
      t.text :value, null: false, default: ''
    end
  end
end
