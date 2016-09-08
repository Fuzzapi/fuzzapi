class CreateVulnerabilities < ActiveRecord::Migration
  def change
    create_table :vulnerabilities do |t|
      t.string :type
      t.integer :scan_id
      t.string :type
      t.string :parameter
      t.text :description
      t.string :value

      t.timestamps null: false
    end
  end
end
