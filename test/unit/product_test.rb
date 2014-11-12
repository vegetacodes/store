require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attribs must not be empty" do 
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?    
  end

  test "price must be positive" do 
    product = Product.new(title: "My book yay!", description: "this book is awesome! it will change yourlife", image_url: "abc.jpg")
    
    product.price = -1
    assert product.invalid?
    assert_equal ["must be >0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than on equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "my title", description: "hello world", price: 1, image_url: image_url)
  end
  
  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/fred.gif}
    bad = %w{ fred.doc fred.gif/more fred.gif.more}

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldnt be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldnt be valid"
    end
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title:       products(:ruby).title,
                          description: "yyy", 
                          price:       1, 
                          image_url:   "fred.gif")

    assert product.invalid?
    assert_equal [I18n.translate('activerecord.errors.messages.taken')],
                 product.errors[:title]
  end  
end
