class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_cart
    # binding.pry
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    # binding.pry
    session[:cart_id] = cart.id
    cart
  end

  def counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end
end
