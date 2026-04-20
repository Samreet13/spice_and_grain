class Province < ApplicationRecord
  has_many :customers
  has_many :orders

  validates :name, presence: true

    def self.ransackable_attributes(auth_object = nil)
  ["id", "name", "gst", "pst", "hst", "created_at", "updated_at"]
end

def self.ransackable_associations(auth_object = nil)
  ["customers", "orders"]
end
end