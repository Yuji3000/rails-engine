class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy
  has_many :customers, through: :invoices



  def self.find_merchant_by_name(name)
    Merchant.where("name ILIKE ?", "%#{name}%").first
  end
end
