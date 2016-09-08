class AddStatusToVulnerabilities < ActiveRecord::Migration
  def change
    add_column :vulnerabilities, :status, :string
  end
end
