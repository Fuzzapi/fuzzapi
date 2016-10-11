class AddUserIdColumnToScans < ActiveRecord::Migration
  def change
    add_reference :scans, :user, index: true, foreign_key: true
  end
end
