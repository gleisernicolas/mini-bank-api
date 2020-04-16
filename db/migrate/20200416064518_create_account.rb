class CreateAccount < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :cpf, null: false
      t.string :birth_date
      t.string :gender
      t.string :city
      t.string :state
      t.string :country
      t.string :referral_code
      t.string :my_referral_code

      t.timestamps
    end
  end
end
