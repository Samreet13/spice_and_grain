# Order model handles pricing, taxes, and status tracking
class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :province

  has_many :order_items
  has_many :products, through: :order_items

  validates :total, presence: true

  enum :status, { new_order: 0, paid: 1, shipped: 2 }

  def self.ransackable_attributes(auth_object = nil)
    column_names
  end

  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map(&:name).map(&:to_s)
  end
end