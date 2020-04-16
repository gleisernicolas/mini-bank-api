class Account < ApplicationRecord
    validates_uniqueness_of :cpf
    
    attribute :name, :encrypted, random_iv: false
    attribute :email, :encrypted, random_iv: false
    attribute :cpf, :encrypted, random_iv: false
    attribute :birth_date, :encrypted, type: :date, random_iv: false
end
