class PaymentsController < ApplicationController
    before_action :authenticate_user!
  
    def create_checkout_session
      # Create a Stripe Checkout session
      @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: params[:cart_items].map do |item|
          product = Product.find(item[:product_id])
          {
            price_data: {
              currency: 'inr', # Indian Rupees
              product_data: {
                name: product.name,
                # Additional product details can be added here
              },
              unit_amount: (product.price.to_f * item[:quantity].to_i * 100).to_i, # Price in paise
            },
            quantity: item[:quantity].to_i, # Ensure quantity is an integer
          }
        end,
        mode: 'payment',
        success_url: success_payments_url,
        cancel_url: cancel_payments_url,
        customer_email: current_user.email, # Store customer email in Stripe
        metadata: {
          customer_name: current_user.full_name, # Add customer name
          customer_address: current_user.address   # Add customer address
        }
      })
  
      # Redirect to the Stripe Checkout session URL
      redirect_to @session.url, allow_other_host: true 
    end
  
    def success
      # Handle successful payment here
      @cart_items = current_user.cart_items
      Order.create(user: current_user, total_amount: calculate_total(@cart_items), status: "paid")
      current_user.cart_items.destroy_all
      flash[:notice] = 'Payment was successful! Thank you for your purchase.'
      redirect_to root_path
    end
  
    def cancel
      # Handle canceled payment here
      flash[:alert] = 'Payment was canceled. You can try again.'
      redirect_to cart_path(current_user.cart)
    end
  
    private
  
    # Calculate the total amount for the cart items
    def calculate_total(cart_items)
      cart_items.sum { |item| item.quantity * Product.find(item.product_id).price.to_f }
    end
  end
  