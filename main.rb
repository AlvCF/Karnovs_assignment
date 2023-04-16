require_relative "./lib/checkout"
require_relative "./lib/product"
require_relative "./lib/promotion"
require_relative "./lib/promotion_product"
require_relative "./lib/promotion_total"

red_scarf         = Product.new("001","Red Scarf",9.25)
silver_cufflinks  = Product.new("002","Silver cufflinks",45.0)
silk_dress        = Product.new("003","Silk Dress",19.95)


first_promotion = PromotionProduct.new(false,0.75,"001",2)
second_promotion = PromotionTotal.new(true,0.1,60)

promotional_rules = []
promotional_rules << first_promotion
promotional_rules << second_promotion

first_co = Checkout.new(promotional_rules)
first_co.scan(red_scarf)
first_co.scan(silver_cufflinks)
first_co.scan(silk_dress)
first_price = first_co.total

puts "Basket: #{first_co.show_basket}"
puts "Total price: £#{first_price}"

second_co = Checkout.new(promotional_rules)
second_co.scan(red_scarf)
second_co.scan(silk_dress)
second_co.scan(red_scarf)
second_price = second_co.total

puts "Basket: #{second_co.show_basket}"
puts "Total price: £#{second_price}"

third_co = Checkout.new(promotional_rules)
third_co.scan(red_scarf)
third_co.scan(silver_cufflinks)
third_co.scan(red_scarf)
third_co.scan(silk_dress )
third_price = third_co.total

puts "Basket: #{third_co.show_basket}"
puts "Total price: £#{third_price}"
