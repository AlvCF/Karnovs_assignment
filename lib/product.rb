class Product
  # require_relative 'transfer'

  attr_accessor :code,:price

  # has_one: checkout esto lo dejo comentado por ahora
  

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end




end