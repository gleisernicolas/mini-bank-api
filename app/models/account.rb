class Account < ApplicationRecord
  validates_uniqueness_of :cpf, :my_referral_code
  validates_presence_of :cpf, :user, :status
  validates :status, inclusion: { in: ['pending', 'completed'] }
  validates :name, :gender, :city, :state, :country,  length: { minimum: 2 }, allow_nil: true
  validates :referral_code, :my_referral_code, length: { minimum: 8 }, allow_nil: true
  validate :birth_date_format

  validates_format_of :email, with: /\A(\S+)@(.+)\.(\S+)\z/, allow_nil: true

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

  def  birth_date_format
    return if birth_date.nil?

    errors.add(:birth_date, "must be a valid date") unless (DateTime.parse(birth_date.to_s) rescue false)
  end
end
