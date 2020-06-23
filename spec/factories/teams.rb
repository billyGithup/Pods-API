FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
    lead { Faker::Name.name }
    active { false }
  end
end
