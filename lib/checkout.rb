class Checkout

  attr_accessor :total, :products, :discounts

  

  def initialize(promotional_rules)
    @products = []
    @total = 0
    @discounts = []

    #&& !pr.product_code.blank? 
    @product_promotions = promotional_rules.select{|pr| pr.type == "product" }.group_by{|p| p.product_code} || [] 
    @total_promotions   = promotional_rules.select{|pr| pr.type == "total"} || []
  end


  def scan(item)
    add_product(item)

    (@product_promotions[item.code] || []).each do |prod_prom| 
      prod_prom.apply_product_promotion(self)
    end

    calculate_total

    #self.
    (@total_promotions || []).each do |tot_prom|
      tot_prom.apply_total_promotion(self)
    end

    self.total
  end

  def show_basket
    self.products.map{|pr| pr.code}.join(", ")
  end

  private

    def add_product(item)
      self.products << item
    end

    def calculate_total
      total = 0
      self.products.each{ |pr| total += pr.price}
      self.discounts.each{ |dis| total -= dis}
      self.total = total.round(2)
    end

end