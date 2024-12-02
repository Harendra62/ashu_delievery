class OrdersController < ApplicationController
    before_action :authenticate_user!
    def index 
      @order = current_user.orders.includes(:user) 
    end

    def create
      @order = current_user.orders.create(order_params)
      if @order.save
        redirect_to new_order_payment_path(@order)
      else
        render :new
      end
    end
  
    private
  
    def order_params
      params.require(:order).permit(:total_amount)
    end
  end