FactoryBot.define do
  factory :order_payment do
    user_id{ Faker::Number.between(from: 1, to: 10000)}
    item_id{ Faker::Number.between(from: 1, to: 10000)}
    postal_code{ "123-4567" }
    prefecture_id{ Faker::Number.between(from: 1, to: 47) }
    city{ Faker::Address.city}
    addresses{ Faker::Address.street_address}
    building{ Faker::Address.secondary_address}
    phone_number{ "01234567890"}
    token{ Faker::Lorem.characters(32)}
  end
end