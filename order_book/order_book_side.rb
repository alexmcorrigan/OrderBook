class OrderBookSide

  attr_reader :orders

  def initialize
    @orders = Hash.new
  end

  def rest(order)
    if @orders.has_key? order.price
      @orders[order.price] << order
    else
      @orders[order.price] = [order]
    end
  end

  def remove_order(order)
    @orders[order.price].delete order
  end

end

class BidOrderBookSide < OrderBookSide
  def initialize
    super
  end

  def prioritise_orders
    prioritised_orders = Array.new
    @orders.sort { |a, b| b <=> a }.each do |price_point|
      prioritised_orders.concat price_point[1]
    end
    prioritised_orders
  end

end

class AskOrderBookSide < OrderBookSide
  def initialize
    super
  end

  def prioritise_orders
    prioritised_orders = Array.new
    @orders.sort { |a, b| a <=> b }.each do |price_point|
      prioritised_orders.concat price_point[1]
    end
    prioritised_orders
  end
end