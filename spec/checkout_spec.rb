# frozen_string_literal: true

require 'checkout'
require 'product'
require "promotion"
require 'promotion_total'
require 'promotion_product'

RSpec.describe Checkout, '#calculate' do
  context 'Scan item' do
    it 'should be correct' do
      first_promotion, second_promotion, red_scarf, silver_cufflinks,silk_dress = prepare_data
      first_checkout = described_class.new([first_promotion,second_promotion])
      first_checkout.scan(red_scarf)
      expect(first_checkout.total).to eq(9.25)
    end
  end

end

def prepare_data
  red_scarf         = Product.new("001","Red Scarf",9.25)
  silver_cufflinks  = Product.new("002","Silver cufflinks",45.0)
  silk_dress        = Product.new("003","Silk Dress",19.95)


  first_promotion   = PromotionProduct.new(false,0.75,"001",2)
  second_promotion  = PromotionTotal.new(true,0.1,60)

  [first_promotion, second_promotion, red_scarf, silver_cufflinks,silk_dress]
end