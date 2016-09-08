class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.string :url
      t.string :sid
      t.string :parameters
      t.string :method
      t.string :cookies
      t.timestamps null: false
    end
  end
end
