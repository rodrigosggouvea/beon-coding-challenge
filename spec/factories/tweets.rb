FactoryBot.define do
  factory :tweet do
    association :user
    body { Faker::GreekPhilosophers.quote }
  end
end
