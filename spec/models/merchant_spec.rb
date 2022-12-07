require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant1 = Merchant.create!(name: "thomas")
    @item1 = Item.create!(name: 'toy', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
  end

  describe "relationships" do
    it {should have_many(:items)}
    it {should have_many(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end
end