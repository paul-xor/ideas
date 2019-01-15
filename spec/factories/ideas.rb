FactoryBot.define do
  factory :idea do
    title { Faker::Community.quotes }
    description { Faker::Hacker.say_something_smart }
  end
end
