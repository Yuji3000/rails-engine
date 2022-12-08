require 'rails_helper'
RSpec.describe Item, type: :model do
  before(:all) do
    @merchant1 = Merchant.create!(name: 'New')
    @item1 = Item.create!(name: 'toy', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'doggie toy', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'frong', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: 'taaaaw', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
    @item5 = Item.create!(name: 'bababa', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
    @item6 = Item.create!(name: 'tOys', description: "its a toys", unit_price: 1.1, merchant_id: @merchant1.id)
  end
  
  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'find_by_name' do
    it 'can find various items based on the name' do
      expect(Item.find_by_name("toy")).to eq([@item1, @item2, @item6])
    end
  end
end