FactoryBot.define do
  factory :rate do
    post
    value { 1..5 }
  end
end
