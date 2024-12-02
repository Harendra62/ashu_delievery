class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
    @cart_items = @cart.cart_items.includes(:product)
  end

  def update
    cart_item = current_user.cart.cart_items.find_by(id: params[:id])

    if cart_item && cart_item.update(cart_item_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to cart_path(current_user.cart), notice: "Cart updated." }
      end
    else
      redirect_to cart_path(current_user.cart), alert: "Unable to update item."
    end
  end

  def add_item
    @cart = current_user.cart
    product = Product.find_by(id: params[:product_id])

    if product
      cart_item = @cart.cart_items.find_or_initialize_by(product: product)
      cart_item.quantity = (cart_item.quantity || 0) + (params[:quantity] || 1).to_i

      if cart_item.save
        flash[:notice] = "#{cart_item.quantity} item(s) of #{product.name} added to your cart."
      else
        flash[:alert] = "Failed to add item to cart."
      end
    else
      flash[:alert] = "Product not found."
    end

    redirect_to cart_path(@cart)
  end

  def remove_item
    @cart = current_user.cart
    cart_item = @cart.cart_items.find_by(id: params[:id])

    if cart_item
      cart_item.destroy
      flash[:notice] = "Item removed from cart."
    else
      flash[:alert] = "Item not found in cart."
    end

    redirect_to cart_path(@cart)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
