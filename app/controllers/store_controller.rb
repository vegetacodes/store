class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @cart = current_cart
    @count = counter
  end
end
