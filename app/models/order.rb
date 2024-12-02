class Order < ApplicationRecord
  belongs_to :user
  has_many :payments, dependent: :destroy
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
