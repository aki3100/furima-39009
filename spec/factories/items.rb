FactoryBot.define do
  factory :item do
    association :user

    item_name                    {Faker::Name.name}
    item_info                    {Faker::Lorem.sentence}
    category_id                  {Faker::Number.between(from: 1, to: 10) }
    item_status_id               {Faker::Number.between(from: 1, to: 6)} 
    shopping_fee_status_id       {Faker::Number.between(from: 1, to: 11) }
    prefecture_id                {Faker::Number.between(from: 1, to: 2) }
    shopping_date_id             {Faker::Number.between(from: 1, to: 3) }
    price                        {Faker::Number.between(from: 300, to: 9999999) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
