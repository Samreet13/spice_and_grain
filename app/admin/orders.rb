ActiveAdmin.register Order do

  permit_params :status

  index do
    selectable_column
    id_column
    column :customer
    column :total
    column :status
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :customer
      row :subtotal
      row :gst
      row :pst
      row :hst
      row :total
      row :status
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :status, as: :select, collection: Order.statuses.keys
    end
    f.actions
  end

end