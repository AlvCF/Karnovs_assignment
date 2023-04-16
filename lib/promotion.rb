class Promotion

  attr_accessor :type, :product_code,:required_quantity,:required_total,:percentage,:value

  

  def initialize(type,product_code = nil, required_quantity = 0, required_total = 0, percentage, value)
    @type = type
    @product_code = product_code
    @required_quantity = required_quantity
    @required_total = required_total
    @percentage = percentage
    @value = value
  end

  def apply_product_promotion(checkout)

    discounted_products = checkout.products.select{|prod| prod.code == self.product_code}
    if self.type == "product" 

      if discounted_products.size == self.required_quantity && self.required_quantity != 0
        discounted_products.each do |dis_prod|  
          checkout.discounts << apply_discount(dis_prod.price)
        end
      elsif discounted_products.size > self.required_quantity || self.required_quantity == 0
        checkout.discounts << apply_discount(discounted_products.last.price)
      end
    end
  end

  def apply_total_promotion(checkout)
    if checkout.total >= self.required_total && self.type == "total"
      checkout.total = (checkout.total - apply_discount(checkout.total)).round(2)
    end
  end

  private

    def apply_discount(amount)
      if self.percentage
        discount = amount * self.value
      else
        discount = self.value
      end
    end

end