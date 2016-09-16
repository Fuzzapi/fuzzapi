class AddJsonColumnToScans < ActiveRecord::Migration
  def change
    add_column :scans, :json, :boolean, default: false
  end
end
