require './order_book/order_book_side'
class OrderBook

  attr_reader :bids, :asks

  def initialize
    @all_orders = Hash.new
    @bids = BidOrderBookSide.new
    @asks = AskOrderBookSide.new
  end

  def rest_buy_order(order)
    rest_order_on_side @bids, order
  end

  def rest_sell_order(order)
    rest_order_on_side @asks, order
  end

  def remove_buy_order(order)
    remove_order_from_side(@bids, order)
  end


  def remove_sell_order(order)
    remove_order_from_side(@asks, order)
  end

  def action_cancel_request(cancel_request)
    if @all_orders[cancel_request.original_order_id]
      @all_orders[cancel_request.original_order_id].cancel(self)
    else
      raise OrderDoesNotExistError.new(cancel_request)
    end
  end

  private

  def rest_order_on_side(side, order)
    side.rest order
    @all_orders[order.order_id] = order
  end

  def remove_order_from_side(side, order)
    @all_orders.delete_if {|k,v| v == order}
    side.remove_order order
  end

end