class AddPhotoAndAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :photo_url, :string, :default => nil
    add_column :users, :admin, :boolean, :default => false
  end
end
