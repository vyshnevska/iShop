class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy

  def add_product(product)
    item = cart_items.find_or_create_by(product_id: product)
    if item
      item.quantity += 1
    else
      cart_items.build(product_id: product)
    end
    item
  end

  def total_price
    cart_items.map(&:total_price).inject(:+)
  end
end
