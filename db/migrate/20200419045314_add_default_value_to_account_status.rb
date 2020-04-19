class AddDefaultValueToAccountStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :accounts, :status, :string,default: 'pending'
  end
end
