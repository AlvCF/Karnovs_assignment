class PromotionProduct < Promotion

  attr_accessor :product_code,:required_quantity,:percentage,:value



  def initialize(percentage,value,product_code, required_quantity = 0)
    super(percentage,value)

    @product_code = product_code
    @required_quantity = required_quantity
  end

  def apply_promotion(checkout)

    discounted_products = checkout.products.select{|prod| prod.code == @product_code}

    #If its the first time that the number of a specific product exceed the required_quantity threshold, it adds a discount for each product
    if discounted_products.size == @required_quantity && @required_quantity != 0
      discounted_products.each do |dis_prod|
        checkout.discounts << apply_discount(dis_prod.price)
      end
    #Otherwise, it only add one discount
    elsif discounted_products.size > @required_quantity || @required_quantity == 0
      checkout.discounts << apply_discount(discounted_products.last.price)
    end
  end


end