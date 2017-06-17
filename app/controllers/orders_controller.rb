class OrdersController < ApplicationController

  before_action :authenticate_user!

  def show
    @order = Order.find_by_token(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      @order.build_item_cache_from_cart(current_cart) #生成商品快照
      @order.calculate_total!(current_cart) #計算訂單總金額
      current_cart.clean! #訂單產生後，購物車應該被清空
      redirect_to order_path(@order.token)
    else
      render "carts/checkout" #回到carts的checkout_action
    end  
  end

  def pay_with_credit_card
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!("credit_card")
    @order.make_payment!

    redirect_to account_orders_path, notice: "成功完成付款"
  end

  private

  def order_params
    params.require(:order).permit( info_attributes: [:billing_name, :billing_address,
                                                    :shipping_name, :shipping_address] )
    #permit_nested_form: another_model_name: [attributes]                                                  
  end

end
