require 'rails_helper'
RSpec.describe Item, type: :model do
  # before :each do
  #   create(:item, name: "toy")
  #   create(:item, name: "Toy")
  #   create(:item, name: "bug tOy")
  #   create(:item, name: "boya")
  # end
  
  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'find_by_name' do
    it 'can find various items based on the name' do
      create(:item, name: "toy")
      create(:item, name: "Toy")
      create(:item, name: "bug tOy")
      create(:item, name: "boya")
      expect(Item.find_by_name("toy").count).to eq(3)
    end

    it 'cant find items' do
      create(:item, name: "toy")
      create(:item, name: "Toy")
      create(:item, name: "bug tOy")
      create(:item, name: "boya")
      expect(Item.find_by_name("stick").count).to eq(0)
    end
  end
end