module CartsHelper
  def format_date date
    date.strftime('%m/%d/%y')
  end

  def mark_current_cart cart_id
    session[:cart_id] == cart_id ? 'current_cart' : ''
  end
end
