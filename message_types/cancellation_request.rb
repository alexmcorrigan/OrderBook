class CancellationRequest

  attr_reader :price, :order_id, :symbol, :original_order_id, :side, :quantity

  def initialize(order_id, original_order_id, symbol, side, quantity, price)
    @order_id = order_id
    @original_order_id = original_order_id
    @symbol = symbol
    @side = side
    @quantity = quantity
    @price = price
  end

end