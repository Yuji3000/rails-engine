FactoryBot.define do
  factory :transaction do
    invoice
    name { Faker::Fantasy::Tolkien.character}
    description { Faker::Quote.yoda }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end