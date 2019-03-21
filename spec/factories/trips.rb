# spec/factories/trips.rb
FactoryBot.define do
  factory :trip do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end
