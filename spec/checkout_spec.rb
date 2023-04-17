# frozen_string_literal: true

require 'checkout'
require 'product'
require "promotion"
require 'promotion_total'
require 'promotion_product'

describe Checkout do
  let(:red_scarf) { Product.new("001","Red Scarf",9.25) }
  let(:first_promotion) { PromotionProduct.new(false,0.75,"001",2) }
  let(:new_checkout) { Checkout.new([:first_promotion])}

  describe '#checkout' do
    context 'when a checkout scans an item' do
      it 'applies promotions and updates the checkouts total' do
        expect{ new_checkout.scan(red_scarf)}.to change(new_checkout, :total).by(9.25)
      end
    end
  end

end
