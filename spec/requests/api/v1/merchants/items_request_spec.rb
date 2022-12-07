require 'rails_helper'

describe "Merchant Items API" do

  it "finds the items from a merchant" do

    a = create_list(:item, 3)
    
    get "/api/v1/merchants/#{a[0].merchant.id}/items"

    expect(response).to be_successful
    
    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]
  
    expect(items.count).to eq(1)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end
end