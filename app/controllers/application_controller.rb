class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!
  before_action :set_active_storage_url_options
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :mobile_number, :pincode, :address, :famous_landscape])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :mobile_number, :pincode, :address, :famous_landscape])
  end

  private

  def current_cart
    current_user.cart || Cart.create(user: current_user)
  end
  def cart
    session[:cart] ||= {}
  end
  def set_active_storage_url_options
    ActiveStorage::Current.url_options = { host: request.base_url }
  end

end
