class CreateAppLogs < ActiveRecord::Migration
  def change
    create_table :app_logs do |t|
      t.references :app
      t.string :module, null: false

    end
  end
end
