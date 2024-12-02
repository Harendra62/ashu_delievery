class Product < ApplicationRecord
  belongs_to :category
  # belongs_to :cart
  # has_many :cart_items
  has_one_attached :product_image
end
