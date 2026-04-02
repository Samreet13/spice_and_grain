class Customer < ApplicationRecord
  has_many :orders

  belongs_to :province, optional: true

  # Devise modules (keep yours as-is if already generated)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    column_names
  end

  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map(&:name).map(&:to_s)
  end
end