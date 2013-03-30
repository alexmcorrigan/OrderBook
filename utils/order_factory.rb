require './message_types/order_request'

class OrderFactory

  def self.new_order(order_id, side, symbol, quantity, price)
    if side == 'B'
      new_buy_order order_id, symbol, quantity, price
    elsif side == 'S'
      new_sell_order order_id, symbol, quantity, price
    else
      raise 'Unrecognised side %s' % [side]
    end
  end

  def self.new_buy_order(order_id, symbol, quantity, price)
    BuyOrderRequest.new(order_id, symbol, quantity, price, Time.now)
  end

  def self.new_sell_order(order_id, symbol, quantity, price)
    SellOrderRequest.new(order_id, symbol, quantity, price, Time.now)
  end
end
