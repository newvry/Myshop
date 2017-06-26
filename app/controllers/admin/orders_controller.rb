class Admin::OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_require

  def index
    @orders = Order.order(":id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship!
    redirect_to admin_order_path(@order)
  end

  def shipped
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_to admin_order_path(@order)
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancell_order!
    redirect_to admin_order_path(@order)
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_to admin_order_path(@order)
  end

  private

  def admin_require
    if !current_user.admin?
      redirect_to "/"
    end
  end

end
