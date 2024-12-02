class ChangeDataType < ActiveRecord::Migration[7.0]
  def up
    change_column :products, :price, :integer
  end
  def down
    change_column :products, :price, :float
  end
end
