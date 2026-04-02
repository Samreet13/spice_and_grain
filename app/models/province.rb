class Province < ApplicationRecord
  has_many :customers
  has_many :orders

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    column_names
  end
end