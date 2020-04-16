FactoryBot.define do
    factory :user do
      name { "John" }
      email  { "Doe" }
      cpf  { "0001001" }
      birth_date  { 20.years.ago.to_date }
      gender  { "Doe" }
      city  { "Doe" }
      state  { "Doe" }
      country  { "Doe" }
      referral_code  { "Doe" }
    end
  end