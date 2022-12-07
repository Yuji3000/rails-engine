require 'rails_helper'
RSpec.describe Item, type: :model do
  # before(:all) do
  #   @merchant1 = Merchant.create!(name: 'New')
  #   @item1 = Item.create!(name: 'toy', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
  # end
  
  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end
end