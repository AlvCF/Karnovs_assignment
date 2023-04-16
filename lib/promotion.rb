class Promotion

  attr_accessor :percentage,:value

  

  def initialize(percentage, value)
    #true if its a percentage discount, false if its a fixed discount
    @percentage = percentage
    #the percentage or fixed amount of money to be discounted
    @value = value
  end


  private

    def apply_discount(amount)
      if @percentage
        discount = amount * @value
      else
        discount = @value
      end
    end

end