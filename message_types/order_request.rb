class OrderRequest

  attr_reader :order_id, :price, :symbol, :side, :quantity, :entry_time

  def to_s
    '{%s %s %s %s %s %s (%s}' % [@order_id, @side, @symbol, @quantity, @price, @entry_time, super.to_s]
  end

  def initialize(order_id, side, symbol, quantity, price, entry_time)
    @order_id = order_id
    @side = side
    @symbol = symbol
    @quantity = quantity
    @price = price
    @entry_time = entry_time
  end

  def ==(other)
    @order_id == other.order_id &&
      @symbol == other.symbol &&
      @side == other.side &&
      @quantity == other.quantity &&
      @price == other.price
  end
end

class BuyOrderRequest < OrderRequest
  def initialize(order_id, symbol, quantity, price, entry_time)
    super(order_id, 'BUY', symbol, quantity, price, entry_time)
  end

  def add_to_order_book(order_book)
    order_book.rest_buy_order(self)
  end

  def cancel(order_book)
    order_book.remove_buy_order(self)
  end
end

class SellOrderRequest < OrderRequest
  def initialize(order_id, symbol, quantity, price, entry_time)
    super(order_id, 'SELL', symbol, quantity, price, entry_time)
  end

  def add_to_order_book(order_book)
    order_book.rest_sell_order(self)
  end

  def cancel(order_book)
    order_book.remove_sell_order(self)
  end
end