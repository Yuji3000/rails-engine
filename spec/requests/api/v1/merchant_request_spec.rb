require 'rails_helper'


describe "Merchant API" do

  it "finds one merchant" do
    merchants = create_list(:merchant, 3)

    get "/api/v1/merchants/#{merchants[0].id}"

    expect(response).to be_successful
    
    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]
  
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)
  end  
end
