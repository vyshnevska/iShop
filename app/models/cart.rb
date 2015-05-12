class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy

  def add_product(product)
    item = cart_items.find_by_product_id(product)
    if item
      item.quantity += 1
    else
      cart_items.build(product_id: product)
    end
    item
  end
end
