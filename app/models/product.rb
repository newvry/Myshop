class Product < ApplicationRecord

  has_one :photo

  accepts_nested_attributes_for :photo
  #之後我們要做nested form，先在這邊設定接受變更Photo底下的attributes

end
