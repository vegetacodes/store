class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @count = counter
  end
end
