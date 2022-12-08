require 'rails_helper'

describe 'item search API' do
  before(:all) do
    @merchant1 = Merchant.create!(name: 'New')
    @item1 = Item.create!(name: 'toy', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'doggie tOy', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'frong', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: 'taaaaw', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
    @item5 = Item.create!(name: 'bababa', description: "its a toy", unit_price: 1.1, merchant_id: @merchant1.id)
    @item6 = Item.create!(name: 'Toys', description: "its a toys", unit_price: 1.1, merchant_id: @merchant1.id)
  end

  it 'it can find one item' do

    get "/api/v1/items/find_all?name=#{@item1.name}"
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]
    # require 'pry'; binding.pry
    expect(items.count).to eq(3)
    expect(items.first[:attributes]).to have_key(:name)
    expect(items.first[:attributes]).to have_key(:description)
    expect(items.first[:attributes]).to have_key(:unit_price)
    expect(items.first[:attributes]).to have_key(:merchant_id)
  end
end