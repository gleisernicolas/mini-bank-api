class Account < ApplicationRecord
  validates_uniqueness_of :cpf, :my_referral_code
  validates_presence_of :cpf, :user, :status
  validates :status, inclusion: { in: ['pending', 'completed'] }

  attribute :name, :encrypted, random_iv: false
  attribute :email, :encrypted, random_iv: false
  attribute :cpf, :encrypted, random_iv: false
  attribute :birth_date, :encrypted, type: :date, random_iv: false

  belongs_to :user

  def complete_account
    return if status == 'completed'
    keys = %i(id status created_at updated_at referral_code my_referral_code)

    return if attributes.symbolize_keys.except(*keys).values.any?(&:nil?)
      
    self.status = 'completed'
    self.my_referral_code = SecureRandom.alphanumeric(8)
    save if persisted?
  end
end
