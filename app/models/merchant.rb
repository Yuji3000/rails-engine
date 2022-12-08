class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.find_merchant_by_name(name)
    Merchant.where("name ILIKE ?", "%#{name}%").first
  end
end
