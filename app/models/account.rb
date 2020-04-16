class Account < ApplicationRecord
  validates_uniqueness_of :cpf
  validates_presence_of :cpf
  validates_presence_of :user

  attribute :name, :encrypted, random_iv: false
  attribute :email, :encrypted, random_iv: false
  attribute :cpf, :encrypted, random_iv: false
  attribute :birth_date, :encrypted, type: :date, random_iv: false

  belongs_to :user
end
