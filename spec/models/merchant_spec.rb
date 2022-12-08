require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe "relationships" do
    it {should have_many(:items)}
    it {should have_many(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'find_merchant_by_name' do
    it 'can find various items based on the name' do
      create(:merchant, name: "Bob")
      create(:merchant, name: "bobo cooldude")
      create(:merchant, name: "bObby Flay")
      # require 'pry~ binding.pry
      expect(Merchant.find_merchant_by_name("Bob").name).to eq("Bob")
    end
  end
end