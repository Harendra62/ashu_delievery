class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart, dependent: :destroy
  after_create :create_cart
  validates :full_name, presence: true
  validates :mobile_number, presence: true
  validates :pincode, presence: true
  validates :address, presence: true
  validates :famous_landscape, presence: true
  validates :mobile_number, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
  validates :pincode, format: { with: /\A\d{6}\z/, message: "must be 6 digits" }
  has_many :orders, dependent: :destroy
  has_many :payments, through: :orders
  validates :stripe_customer_id, uniqueness: true, allow_nil: true
  after_create :create_stripe_customer
  
  def stripe_customer
    return unless stripe_customer_id

    Stripe::Customer.retrieve(stripe_customer_id)
  rescue Stripe::StripeError => e
    errors.add(:base, "Stripe error: #{e.message}")
    nil
  end
  private
  def create_stripe_customer
    return if stripe_customer_id.present?
    customer = Stripe::Customer.create( email: self.email, name: self.full_name, address: { line1: self.address, postal_code: self.pincode} )
    update(stripe_customer_id: customer.id)
  rescue Stripe::StripeError => e
    errors.add(:base, "Stripe error: #{e.message}")
    false
  end
  def create_cart
    Cart.create(user: self)
  end
end
