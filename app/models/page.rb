class Page < ApplicationRecord
  validates :title, :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    column_names
  end
end