class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Product not found"
  end
end
