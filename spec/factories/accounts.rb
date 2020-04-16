FactoryBot.define do
  factory :account do
    name { Faker::Name.name }
    email  { Faker::Internet.email }
    cpf  { Faker::IDNumber.brazilian_citizen_number }
    birth_date  { 20.years.ago.to_date }
    gender  { Faker::Gender.type }
    city  { Faker::Address.city }
    state  { Faker::Address.state }
    country  { Faker::Address.country }
    referral_code  { Faker::Number.number(digits: 8) }
    my_referral_code  { Faker::Number.number(digits: 8) }
    association :user
  end
end