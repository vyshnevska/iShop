class Product < ActiveRecord::Base
  validates :title, :description, :image, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: I18n.t('models.product.validations.image')
  }
  has_many :cart_items
  before_destroy :not_refer_to_cart_item

  mount_uploader :image, ImageUploader

  # Returns the most recently updated product
  def self.latest
    Product.order(:updated_at).last
  end

  private
    # Ensure that there are no cart items referencing this product
    def not_refer_to_cart_item
      if cart_items.empty?
        return true
      else
        errors.add(:base, I18n.t('models.product.validations.lines'))
        return false
      end
    end
end
