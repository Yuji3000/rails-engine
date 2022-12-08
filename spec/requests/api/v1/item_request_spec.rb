require 'rails_helper'

describe "Items API" do
  it "sends one item" do
    create_list(:item, 3)
    create_list(:merchant, 3)
    get "/api/v1/items/#{Item.first.id}"
    
    expect(response).to be_successful
    
    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]
    
    expect(response_body.count).to eq(1)
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

  it 'can create a new item' do
    create_list(:item, 3)
    create_list(:merchant, 3)
    item = {
      "name": "value1",
      "description": "value2",
      "unit_price": 100.99,
      "merchant_id": Merchant.first.id
    }
    headers = {'CONTENT_TYPE' => 'application/json'}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item)

    expect(response).to be_successful

    expect(Item.all.count).to eq(4)
  end

  it 'can update an existing item' do
    id = create(:item).id
  
    previous_name = Item.last.name
  
    item_params = {
                "name": "new name"
                }
   
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    item = Item.find_by(id: id)
    
    expect(response).to be_successful

    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("new name")
  end

  it "can destroy an item" do
    item = create(:item)
  
    expect(Item.count).to eq(1)
  
    delete "/api/v1/items/#{item.id}"
  
    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  # it "sad path" do
  #   item = create(:item, name: "water")
  
  #   expect(Item.count).to eq(1)
  
  #   get "/api/v1/items/34343434343"
  # require 'pry'; binding.pry
  #   # expect(response).to be_successful
  #   expect(Item.count).to eq(1)
  #   expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  # end
end

