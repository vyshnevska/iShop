require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image].any?
  end

  test "product price must be positive" do
    product = products(:product_with_image)
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    product.price = 1
    assert product.valid?
  end

  def load_new_product(image)
    Product.new(title: "Product1", description: "yyy", price: 1, image: fixture_file_upload("files/#{image}"))
  end

  def load_product(params = {})
    Product.new(
      title: params[:title] || products(:ruby).title,
      description: "test description",
      price: 1,
      image: params[:image] || 'test.gif'
    )
  end

  test "product image url must be gif|jpg|png" do
    valid_imgs   = %w{ test.gif test.jpg test.png test.JPG test.Jpg }
    invalid_imgs = %w{ test.doc test.gif/more test.gif.more }
    valid_imgs.each do |name|
      assert load_new_product(name).valid?, "#{name} should be valid"
    end

    invalid_imgs.each do |name|
      assert load_product({:image => name} ).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product has an image" do
    product = products(:product_with_image)
    assert File.exists?(product.image.path)
  end

  test "uploads an image" do
    product = Product.create!(title: "Product1", description: "yyy", price: 1, image: fixture_file_upload('files/test.gif', 'image/gif'))
    assert File.exists?(product.reload.image.file.path)
  end

  test "product is not valid without a unique title" do
    product = load_product
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
    product = load_product
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end
end
