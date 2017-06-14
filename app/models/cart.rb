class Cart < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :items ,through: :cart_items, source: :product
  #當關聯名稱不一致的時候，可以加上source指名是哪一種物件，source需搭配through一起使用，
  #@cart.items可以列出這台車上所有item的資料
  #@cart.cart_items可以列出所有cart_item的資料

  def add_product_to_cart(product)
    ci = cart_items.build
    ci.product = product
    ci.save
  end

end
