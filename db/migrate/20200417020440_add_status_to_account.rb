class AddStatusToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :status, :string
  end
end
