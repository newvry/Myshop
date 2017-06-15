class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_cart
  #要讓view也能用上current_cart，可以使用helper_method

  def current_cart
    @current_cart ||= find_cart
    #如果current_cart為空值，就去呼叫find_cart找是哪一台車
  end

  private

  def find_cart
    cart = Cart.find_by(id: session[:cart_id]) 
    #要先找現在的user有沒有購物車（找session有沒有:cart_id）

    unless cart.present? #如果購物車不存在
      cart = Cart.create #那就要生一台購物車給他
    end

    session[:cart_id] = cart.id #在給他session的ID
    cart

  end

end
