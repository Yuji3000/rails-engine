FactoryBot.define do
  factory :invoice_item do
    invoice
    item
    quantity { Faker::Number.number(1..10) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end