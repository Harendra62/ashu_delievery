ActiveAdmin.register Order do
  # Permit only the specified parameters
  permit_params :user_id, :total_amount, :status

  # Specify that only the edit action should be available
  actions :edit, :index, :show
  
  # Customize the edit form
  form do |f|
    f.inputs 'Order Details' do
      f.input :user, label: 'User', as: :select, collection: User.all.pluck(:full_name, :id)
      f.input :total_amount, label: 'Total Amount'
      f.input :status, label: 'Status', as: :select, collection: ['Pending', 'Delivered', 'Cancelled']
    end
    f.actions do
      f.action :submit, label: "Update Order"  # Keeps only the update button
      f.cancel_link  # Optional: Allows navigation back without updating
    end
  end

  # Add filters as needed
  filter :user
  # filter :status, as: :select, collection: ['Pending', 'Delivered', 'Cancelled']
end
