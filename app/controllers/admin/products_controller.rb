class Admin::ProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_require

  def index
    @products = Product.all
  end

  def new 
    @product = Product.new
    @photo = @product.build_photo
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    if @product.photo.present?
      @photo = @product.photo
    else
      @photo = @product.build_photo
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end


  private

  def product_params
    params.require(:product).permit(:title, 
                                    :description, 
                                    :price, 
                                    :quantity,
                                    photo_attributes: [:image, :id])
                                    # 配合先前在Product model中的設定，使用nested_attributes的設定方式，通過驗證。

  end

  def admin_require
    if !current_user.admin?
      redirect_to "/"
    end
  end

end
