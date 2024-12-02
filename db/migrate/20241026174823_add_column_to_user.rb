class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :pincode, :integer
    add_column :users, :mobile_number, :integer
    add_column :users, :address, :string
    add_column :users, :famous_landscape, :string
    add_column :users, :stripe_customer_id, :string
  end
end
