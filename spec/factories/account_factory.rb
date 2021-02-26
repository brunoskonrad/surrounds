FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    display_name { Faker::Name.first_name }
  end
end