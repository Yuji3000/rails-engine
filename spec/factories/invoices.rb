FactoryBot.define do
  factory :invoice do
    merchant
    customer
    name { Faker::Fantasy::Tolkien.character}
    status { Faker::Quote.yoda }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end