class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.float :amount
      t.string :currency
      t.string :stripe_payment_id
      t.string :status

      t.timestamps
    end
  end
end
