FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    token  { Faker::Internet.password(min_length: 10, max_length: 10) }
  end
end