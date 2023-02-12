FactoryBot.define do
  factory :order_destination do
    token { "tok_abcdefghijk00000000000000000" }
    post_code {Faker::Address.postcode}
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city {Faker::Address.city}
    address {Faker::Address.street_address}
    building_name {Faker::Address.building_number}
    phone_number {Faker::Number.number(digits: 10)}
  end
end
