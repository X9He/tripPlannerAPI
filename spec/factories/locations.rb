# spec/factories/locations.rb
FactoryBot.define do
  factory :location do
    name { Faker::StarWars.character }
    address { Faker::Address }
    trip_id nil
  end
end