class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_by_name(name)
    Item.where("name ILIKE ?", "%#{name.downcase}%")
    # Item.where("name LIKE ?", "%#{name.downcase}%")
    # .order(:name)
    # Item.where("name LIKE ?", "%#{name}%")
  end
end
