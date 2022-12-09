require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful
    # require 'pry'; binding.pry
    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items.count).to eq(3)
   
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
# require 'pry'; binding.pry
    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "will destroy an item/invoice/invoice_item/transaction when it is the only item on the invoice" do
    @merch1 = Merchant.create!(name: "the merchant")
    @cus = Customer.create!(first_name: 'first', last_name: 'last')
    @item1 = Item.create!(name: 'stuff', description: 'its stuff!', unit_price: 1, merchant_id: @merch1.id)
    @item2 = Item.create!(name: 'stuff2', description: 'its stuff!', unit_price: 1, merchant_id: @merch1.id)
    @item3 = Item.create!(name: 'stuff3', description: 'its stuff!', unit_price: 1, merchant_id: @merch1.id)
    @invoice1 = Invoice.create!(customer_id: @cus.id, merchant_id: @merch1.id, status: 'idk')
    @invo_item = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 3)
    # @invo_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 3)
    # @invo_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 2, unit_price: 3)
    @transact = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: '1212', credit_card_expiration_date: '12121', result: 'idk')
   
    # require 'pry'; binding.pry
    delete "/api/v1/items/#{@item1.id}"
    expect(response).to be_successful
    expect(Item.exists?(@item1.id)).to eq(false)
    expect(InvoiceItem.exists?(@invo_item.id)).to eq(false)
    # expect(Invoice.exists?(@invoice1.id)).to eq(false)
    # expect(Transaction.exists?(@transact.id)).to eq(false)

  end

  # it "will destroy an item and transaction/invoice item, but not an invoice when there are more than one item on the invoice" do
  #   @merch1 = Merchant.create!(name: "the merchant")
  #   @cus = Customer.create!(first_name: 'first', last_name: 'last')
  #   @item1 = Item.create!(name: 'stuff', description: 'its stuff!', unit_price: 1, merchant_id: @merch1.id)
  #   @item2 = Item.create!(name: 'stuff2', description: 'its stuff!', unit_price: 1, merchant_id: @merch1.id)
  #   @item3 = Item.create!(name: 'stuff3', description: 'its stuff!', unit_price: 1, merchant_id: @merch1.id)
  #   @invoice1 = Invoice.create!(customer_id: @cus.id, merchant_id: @merch1.id, status: 'idk')
  #   @invo_item = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 3)
  #   @invo_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 3)
  #   @invo_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 3)
  #   @transact = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: '1212', credit_card_expiration_date: '12121', result: 'idk')
   
  #   delete "/api/v1/items/#{@item1.id}"
    
  #   expect(response).to be_successful
  #   expect(Item.exists?(@item1.id)).to eq(false)
  #     expect(Item.exists?(@invo_item.id)).to eq(false)
  #     expect(Item.exists?(@invoice1.id)).to eq(false)
  #     expect(Item.exists?(@transact.id)).to eq(false)
  #   end
end