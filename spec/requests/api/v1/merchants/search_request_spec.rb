require 'rails_helper'

describe 'merchant search API' do
  it 'it can find one merchant' do
    create(:merchant, name: "Bob")
    create(:merchant, name: "bobo cooldude")
    create(:merchant, name: "bObby Flay")

    get "/api/v1/merchants/find?name=#{Merchant.first.name}"
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]
   
    expect(response_body.count).to eq(1)
    expect(merchant).to have_key(:id)
    expect(merchant).to have_key(:type)
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to have_key(:name)
  end
end