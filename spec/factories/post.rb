FactoryBot.define do
  factory :post do
    user
    title      Faker::Lorem.sentence
    content    Faker::Lorem.paragraph
    ip         Faker::Internet.unique.ip_v4_address
    rate_sum   { 0 }
    rate_count { 0 }
  end
end
