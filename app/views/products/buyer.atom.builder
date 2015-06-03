atom_feed do |feed|
  feed.title I18n.t('views.products.feed.buyer', product: @product.title)
  feed.updated @latest_order.try(:updated_at)
  @product.orders.each do |order|
    feed.entry(order) do |entry|
    entry.title I18n.t('views.products.feed.order', order_id: order.id)
    entry.summary type: 'xhtml' do |xhtml|
      xhtml.p I18n.t('views.products.feed.shipped', address: order.address)
      xhtml.table do
        xhtml.tr do
          xhtml.th I18n.t('views.products.feed.product')
          xhtml.th I18n.t('views.products.feed.quantity')
          xhtml.th I18n.t('views.products.feed.total')
        end
        order.cart_items.each do |item|
          xhtml.tr do
            xhtml.td item.product.title
            xhtml.td item.quantity
            xhtml.td number_to_currency item.total_price
          end
        end
        xhtml.tr do
          xhtml.th 'total', colspan: 2
          xhtml.th number_to_currency \
            order.cart_items.map(&:total_price).sum
        end
      end
      xhtml.p I18n.t('views.products.feed.paid', type: order.pay_type)
    end
    entry.author do |author|
      author.name order.name
      author.email order.email
    end
  end
end
end
