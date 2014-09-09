class AddSaltToApp < ActiveRecord::Migration
  def change
    add_column :apps, :salt, :string, default: ''
  end
end
