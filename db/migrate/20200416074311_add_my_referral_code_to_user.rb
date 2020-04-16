class AddMyReferralCodeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :my_referral_code, :string 
  end
end
