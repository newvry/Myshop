class OrdersController < ApplicationController

  before_action :authenticate_user!

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      @order.build_item_cache_from_cart(current_cart) #生成商品快照
      @order.calculate_total!(current_cart) #計算訂單總金額
      redirect_to order_path(@order)
    else
      render "carts/checkout" #回到carts的checkout_action
    end  
  end

  private

  def order_params
    params.require(:order).permit( info_attributes: [:billing_name, :billing_address,
                                                    :shipping_name, :shipping_address] )
    #permit_nested_form: another_model_name: [attributes]                                                  
  end

end
