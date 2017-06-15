class CartsController < ApplicationController

  before_action :authenticate_user!, only:[ :checkout ]
  #進入訂單頁之前必須要先檢查是否處於登入狀態

  def checkout
    @order = current_user.orders.build #一定是current_user下訂單
    @info = @order.build_info
  end

end
