class Account::OrdersController < ApplicationController

  before_action :authenticate_user! 

  def index
    @orders = current_user.orders.order("id DESC") #訂單從 newest -> oldest 排序
  end

end
