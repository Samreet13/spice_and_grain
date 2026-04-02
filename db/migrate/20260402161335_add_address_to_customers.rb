class AddAddressToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :address, :string
    add_column :customers, :city, :string
    add_column :customers, :postal_code, :string
  end
end
