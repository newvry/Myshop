class Admin::ProductsController < ApplicationController

  def index
    @product = Product.all
  end

  def new 
    @product = Product.new
  end

  def create
    @product = Product.new
    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end


  private

  def product_params
    params.require(:prodcut).permit(:title, :description, :price, :quantity)
  end

end
