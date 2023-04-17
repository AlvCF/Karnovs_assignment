class Checkout

  attr_accessor :total, :products, :discounts

  

  def initialize(promotional_rules)
    @products = []
    @total = 0
    @discounts = []

    #&& !pr.product_code.blank? 
    @product_promotions = promotional_rules.select{|pr| pr.class == PromotionProduct }.group_by{|p| p.product_code} || []
    @total_promotions   = promotional_rules.select{|pr| pr.class == PromotionTotal} || []
  end


  def scan(item)
    add_product(item)

    (@product_promotions[item.code] || []).each do |prod_prom| 
      prod_prom.apply_promotion(self)
    end

    calculate_total

    @total_promotions.each do |tot_prom|
      tot_prom.apply_promotion(self)
    end

  end

  def show_basket
    @products.map{|pr| pr.code}.join(", ")
  end

  private

    def add_product(item)
      @products << item
    end

    def calculate_total
      total = 0
      @products.each{ |pr| total += pr.price}
      @discounts.each{ |dis| total -= dis}
      @total = total.round(2)
    end

end