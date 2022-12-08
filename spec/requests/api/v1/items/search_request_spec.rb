require 'rails_helper'

describe 'item search API' do
  before :each do
    create(:item, name: "toy")
    create(:item, name: "Toy")
    create(:item, name: "bug tOy")
  end

  it 'it can find one item' do

    get "/api/v1/items/find_all?name=#{Item.first.name}"
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]
 
    expect(items.count).to eq(3)
    expect(items.first[:attributes]).to have_key(:name)
    expect(items.first[:attributes]).to have_key(:description)
    expect(items.first[:attributes]).to have_key(:unit_price)
    expect(items.first[:attributes]).to have_key(:merchant_id)
  end
end