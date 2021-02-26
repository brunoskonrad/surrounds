FactoryBot.define do
  factory :session do
    token { Faker::Internet.uuid }
  end
end