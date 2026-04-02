class Product < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :order_items
  has_one_attached :image
  
 validates :name, presence: true
validates :price, presence: true, numericality: true
validates :stock_quantity, presence: true, numericality: { only_integer: true }
def self.ransackable_associations(auth_object = nil)
  ["categories", "image_attachment", "image_blob", "order_items", "product_categories"]
end

def self.ransackable_attributes(auth_object = nil)
  ["id", "name", "description", "price", "stock_quantity", "on_sale", "sale_price", "created_at", "updated_at"]
end

end