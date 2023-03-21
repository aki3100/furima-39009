FactoryBot.define do
  factory :order_payment do
    postal_code { '123-4567' }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    addresses { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { '01234567890' }
    token { "tok_01a23b4511111111111111111111" }
  end
end
