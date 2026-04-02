class AddFieldsToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :subtotal, :decimal
    add_column :orders, :tax, :decimal
    add_column :orders, :customer_id, :integer
  end
end
