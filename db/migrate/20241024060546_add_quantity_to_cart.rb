class AddQuantityToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :Quantity, :integer
    add_column :carts, :total_price, :float
  end
end
