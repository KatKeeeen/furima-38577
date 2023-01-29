FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    description { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 11) }
    state_id { Faker::Number.between(from: 2, to: 7) }
    shopping_charge_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    delivery_time_id { Faker::Number.between(from: 2, to: 4) }
    
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/gorira.jpeg'), filename: 'gorira.jpeg')
    end
  end
end
