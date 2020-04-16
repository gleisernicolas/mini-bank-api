class User < ApplicationRecord
  validates_presence_of :token, :name
  validates_uniqueness_of :token

  attribute :token, :encrypted, random_iv: false
  attribute :name, :encrypted, random_iv: false

  has_many :accounts
end
