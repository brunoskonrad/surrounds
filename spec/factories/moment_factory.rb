FactoryBot.define do
  factory :moment do
    message { Faker::Lorem.paragraph }
    position { spec_point(Faker::Address.latitude, Faker::Address.longitude) }
  end
end