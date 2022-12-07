FactoryBot.define do
  factory :item do
    merchant
    name { Faker::Fantasy::Tolkien.character}
    description { Faker::Quote.yoda }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end