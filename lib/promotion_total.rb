class PromotionTotal < Promotion

  attr_accessor :required_total,:percentage,:value



  def initialize(percentage,value,required_total = 0)
    super(percentage,value)

    @required_total = required_total
  end

  def apply_promotion(checkout)
    if checkout.total >= @required_total
      checkout.total = (checkout.total - apply_discount(checkout.total)).round(2)
    end
  end

end