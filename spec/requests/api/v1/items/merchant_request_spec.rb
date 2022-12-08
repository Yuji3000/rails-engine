require 'rails_helper'

describe "Merchant from an Item API" do
  it 'finds a merchant from an item id' do
    a = create_list(:item, 3)

    get "/api/v1/items/#{a[0].id}/merchant"
    
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]
    
    expect(response_body.count).to eq(1)
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)
  end
end